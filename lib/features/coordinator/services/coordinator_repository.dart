import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../data/app_database.dart';
import '../../../shared/models/models.dart';
import '../domain/coordinator_validators.dart';
import 'coordinator_firestore_service.dart';

class CoordinatorRepository {
  CoordinatorRepository({
    required AppDatabase database,
    CoordinatorFirestoreService? remote,
    CoordinatorReviewPolicy? policy,
  })  : _database = database,
        _remote = remote ?? CoordinatorFirestoreService(),
        _policy = policy ?? const CoordinatorReviewPolicy();

  final AppDatabase _database;
  final CoordinatorFirestoreService _remote;
  final CoordinatorReviewPolicy _policy;

  static const Uuid _uuid = Uuid();

  Stream<List<SolicitudMobilidadData>> watchSolicitudes() {
    return _database.watchSolicitudes();
  }

  Stream<SolicitudMobilidadData?> watchSolicitud(String id) {
    return watchSolicitudes().map((items) {
      for (final item in items) {
        if (item.id == id) return item;
      }
      return null;
    });
  }

  Stream<List<AprobacionData>> watchAprobaciones(String solicitudId) {
    return (_database.select(_database.aprobacion)
          ..where((t) => t.solicitudId.equals(solicitudId))
          ..orderBy([(t) => OrderingTerm.desc(t.fechaDecision)]))
        .watch();
  }

  Future<List<AprobacionData>> getAprobaciones(String solicitudId) {
    return _database.getAprobacionesDeSolicitud(solicitudId);
  }

  Stream<CoordinatorDashboardCounts> watchCounts() {
    return watchSolicitudes().map((items) {
      final pending = items.where((item) => item.estado == 'enviada').length;
      final approved = items.where((item) => item.estado == 'aprobada').length;
      final rejected = items.where((item) => item.estado == 'rechazada').length;
      return CoordinatorDashboardCounts(
        total: items.length,
        pending: pending,
        approved: approved,
        rejected: rejected,
      );
    });
  }

  Future<void> approve({
    required UsuarioData actor,
    required String solicitudId,
    String comentario = '',
  }) async {
    final solicitud = await _database.getSolicitudById(solicitudId);
    if (solicitud == null) {
      throw StateError('Solicitud no encontrada.');
    }

    _policy.ensureCanApprove(actor, solicitud);

    final now = DateTime.now();
    final remark = comentario.trim();
    final historyComment = remark.isEmpty
        ? 'Solicitud aprobada por el coordinador.'
        : remark;

    await _database.transaction(() async {
      await _database.into(_database.aprobacion).insert(
            AprobacionCompanion.insert(
              id: _uuid.v4(),
              solicitudId: solicitud.id,
              coordinadorId: actor.id,
              usuarioId: solicitud.estudianteId,
              decision: 'aprobada',
              comentario: historyComment,
              fechaDecision: now,
              pendingSync: const Value(true),
            ),
          );

      await (_database.update(_database.solicitudMovilidad)
            ..where((t) => t.id.equals(solicitud.id)))
          .write(
        SolicitudMovilidadCompanion(
          estado: const Value('aprobada'),
          bloqueada: const Value(true),
          fechaActualizacion: Value(now),
          pendingSync: const Value(true),
        ),
      );
    });

    await syncSolicitud(solicitudId);
  }

  Future<void> reject({
    required UsuarioData actor,
    required String solicitudId,
    required String motivo,
  }) async {
    final solicitud = await _database.getSolicitudById(solicitudId);
    if (solicitud == null) {
      throw StateError('Solicitud no encontrada.');
    }

    _policy.ensureCanReject(actor, solicitud, motivo: motivo);

    final now = DateTime.now();
    final reason = motivo.trim();

    await _database.transaction(() async {
      await _database.into(_database.aprobacion).insert(
            AprobacionCompanion.insert(
              id: _uuid.v4(),
              solicitudId: solicitud.id,
              coordinadorId: actor.id,
              usuarioId: solicitud.estudianteId,
              decision: 'rechazada',
              comentario: reason,
              fechaDecision: now,
              pendingSync: const Value(true),
            ),
          );

      await (_database.update(_database.solicitudMovilidad)
            ..where((t) => t.id.equals(solicitud.id)))
          .write(
        SolicitudMovilidadCompanion(
          estado: const Value('rechazada'),
          bloqueada: const Value(true),
          fechaActualizacion: Value(now),
          pendingSync: const Value(true),
        ),
      );
    });

    await syncSolicitud(solicitudId);
  }

  Future<void> syncSolicitud(String solicitudId) async {
    final solicitud = await _database.getSolicitudById(solicitudId);
    if (solicitud == null) return;

    final aprobaciones = await _database.getAprobacionesDeSolicitud(solicitudId);

    try {
      await _remote.upsertSolicitudBundle(
        solicitud: _toRemoteSolicitud(solicitud),
        aprobaciones: aprobaciones.map(_toRemoteAprobacion).toList(),
      );
      await _markSynced(solicitudId);
      await _syncDownSolicitud(solicitudId);
    } catch (_) {
      // Offline-first: local pending flags stay intact if remote sync fails.
    }
  }

  Future<void> syncPending() async {
    final pendingSolicitudes = await _database.getSolicitudesPendientesSync();
    final pendingAprobaciones = await (_database.select(_database.aprobacion)
          ..where((t) => t.pendingSync.equals(true)))
        .get();

    final pendingIds = <String>{
      ...pendingSolicitudes.map((item) => item.id),
      ...pendingAprobaciones.map((item) => item.solicitudId),
    };

    for (final solicitudId in pendingIds) {
      await syncSolicitud(solicitudId);
    }

    await syncDown();
  }

  Future<void> syncDown() async {
    try {
      final remoteSolicitudes = await _remote.fetchSolicitudes();
      for (final remoteSolicitud in remoteSolicitudes) {
        try {
          await _syncDownSolicitudModel(remoteSolicitud);
        } catch (_) {
          // Skip a malformed remote item and continue with the rest.
        }
      }
    } catch (_) {
      // Remote refresh is best-effort; local data stays available offline.
    }
  }

  Future<void> _syncDownSolicitud(String solicitudId) async {
    final remoteSolicitud = await _remote.fetchSolicitud(solicitudId);
    if (remoteSolicitud == null) return;

    await _syncDownSolicitudModel(remoteSolicitud);
  }

  Future<void> _syncDownSolicitudModel(
    SolicitudMovilidadModel remoteSolicitud,
  ) async {
    final localSolicitud =
        await _database.getSolicitudById(remoteSolicitud.id);
    if (localSolicitud != null && localSolicitud.pendingSync) {
      return;
    }

    await _upsertSolicitudLocal(remoteSolicitud);

    final remoteAprobaciones =
        await _remote.fetchAprobaciones(remoteSolicitud.id);
    for (final remoteAprobacion in remoteAprobaciones) {
      final existingAprobacion = await (_database.select(_database.aprobacion)
            ..where((t) => t.id.equals(remoteAprobacion.id)))
          .getSingleOrNull();
      if (existingAprobacion != null && existingAprobacion.pendingSync) {
        continue;
      }
      await _upsertAprobacionLocal(remoteAprobacion);
    }
  }

  Future<void> _upsertSolicitudLocal(
    SolicitudMovilidadModel solicitud,
  ) async {
    await _database.into(_database.solicitudMovilidad).insertOnConflictUpdate(
      SolicitudMovilidadCompanion.insert(
        id: solicitud.id,
        estudianteId: solicitud.estudianteId,
        tipoMovilidad: solicitud.tipoMovilidad,
        nombres: Value(solicitud.nombres),
        apellidos: Value(solicitud.apellidos),
        tipoDocumento: Value(solicitud.tipoDocumento),
        numeroDocumento: Value(solicitud.numeroDocumento),
        fechaNacimiento: solicitud.fechaNacimiento,
        emailInstitucional: solicitud.emailInstitucional,
        emailPersonal: solicitud.emailPersonal,
        telefono: solicitud.telefono,
        contactoEmergencia: solicitud.contactoEmergencia,
        relacionContacto: solicitud.relacionContacto,
        universidadActual: Value(solicitud.universidadActual),
        facultad: Value(solicitud.facultad),
        universidadDestinoId: solicitud.universidadDestinoId,
        universidadDestinoNombre: Value(solicitud.universidadDestinoNombre),
        paisDestino: Value(solicitud.paisDestino),
        ciudadDestino: Value(solicitud.ciudadDestino),
        facultadDestino: Value(solicitud.facultadDestino),
        areaEstudio: Value(solicitud.areaEstudio),
        programaAcademico: solicitud.programaAcademico,
        semestre: solicitud.semestre,
        promedioAcumulado: Value(solicitud.promedioAcumulado),
        nivelIdioma: Value(solicitud.nivelIdioma),
        puntajeIdioma: Value(solicitud.puntajeIdioma),
        semestreIntercambio: Value(solicitud.semestreIntercambio),
        fechaViaje: Value(solicitud.fechaViaje),
        fechaRegreso: Value(solicitud.fechaRegreso),
        estado: Value(solicitud.estado),
        bloqueada: Value(solicitud.bloqueada),
        fechaCreacion: solicitud.fechaCreacion,
        fechaActualizacion: solicitud.fechaActualizacion,
        pendingSync: Value(solicitud.pendingSync),
      ),
    );
  }

  Future<void> _upsertAprobacionLocal(AprobacionModel aprobacion) async {
    await _database.into(_database.aprobacion).insertOnConflictUpdate(
      AprobacionCompanion.insert(
        id: aprobacion.id,
        solicitudId: aprobacion.solicitudId,
        coordinadorId: aprobacion.coordinadorId,
        usuarioId: aprobacion.usuarioId,
        decision: aprobacion.decision,
        comentario: aprobacion.comentario,
        fechaDecision: aprobacion.fechaDecision,
        pendingSync: Value(aprobacion.pendingSync),
      ),
    );
  }

  SolicitudMovilidadModel _toRemoteSolicitud(SolicitudMobilidadData solicitud) {
    return SolicitudMovilidadModel(
      id: solicitud.id,
      estudianteId: solicitud.estudianteId,
      tipoMovilidad: solicitud.tipoMovilidad,
      nombres: solicitud.nombres,
      apellidos: solicitud.apellidos,
      tipoDocumento: solicitud.tipoDocumento,
      numeroDocumento: solicitud.numeroDocumento,
      fechaNacimiento: solicitud.fechaNacimiento,
      emailInstitucional: solicitud.emailInstitucional,
      emailPersonal: solicitud.emailPersonal,
      telefono: solicitud.telefono,
      contactoEmergencia: solicitud.contactoEmergencia,
      relacionContacto: solicitud.relacionContacto,
      universidadActual: solicitud.universidadActual,
      facultad: solicitud.facultad,
      universidadDestinoId: solicitud.universidadDestinoId,
      universidadDestinoNombre: solicitud.universidadDestinoNombre,
      paisDestino: solicitud.paisDestino,
      ciudadDestino: solicitud.ciudadDestino,
      facultadDestino: solicitud.facultadDestino,
      areaEstudio: solicitud.areaEstudio,
      programaAcademico: solicitud.programaAcademico,
      semestre: solicitud.semestre,
      promedioAcumulado: solicitud.promedioAcumulado,
      nivelIdioma: solicitud.nivelIdioma,
      puntajeIdioma: solicitud.puntajeIdioma,
      semestreIntercambio: solicitud.semestreIntercambio,
      fechaViaje: solicitud.fechaViaje,
      fechaRegreso: solicitud.fechaRegreso,
      estado: solicitud.estado,
      bloqueada: solicitud.bloqueada,
      fechaCreacion: solicitud.fechaCreacion,
      fechaActualizacion: solicitud.fechaActualizacion,
      pendingSync: solicitud.pendingSync,
    );
  }

  AprobacionModel _toRemoteAprobacion(AprobacionData aprobacion) {
    return AprobacionModel(
      id: aprobacion.id,
      solicitudId: aprobacion.solicitudId,
      coordinadorId: aprobacion.coordinadorId,
      usuarioId: aprobacion.usuarioId,
      decision: aprobacion.decision,
      comentario: aprobacion.comentario,
      fechaDecision: aprobacion.fechaDecision,
      pendingSync: aprobacion.pendingSync,
    );
  }

  Future<void> _markSynced(String solicitudId) async {
    await _database.marcarSolicitudSincronizada(solicitudId);
    await (_database.update(_database.aprobacion)
          ..where((t) => t.solicitudId.equals(solicitudId)))
        .write(
      const AprobacionCompanion(pendingSync: Value(false)),
    );
  }
}

class CoordinatorDashboardCounts {
  const CoordinatorDashboardCounts({
    required this.total,
    required this.pending,
    required this.approved,
    required this.rejected,
  });

  final int total;
  final int pending;
  final int approved;
  final int rejected;
}
