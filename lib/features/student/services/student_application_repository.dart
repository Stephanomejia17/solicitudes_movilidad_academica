import 'dart:async';

import 'package:drift/drift.dart';

import '../../../data/app_database.dart';
import '../../../shared/models/models.dart';
import 'student_firestore_service.dart';

class StudentApplicationDraft {
  const StudentApplicationDraft({
    required this.estudiante,
    required this.tipoMovilidad,
    required this.nombres,
    required this.apellidos,
    required this.tipoDocumento,
    required this.numeroDocumento,
    required this.fechaNacimiento,
    required this.emailInstitucional,
    required this.emailPersonal,
    required this.telefono,
    required this.contactoEmergencia,
    required this.relacionContacto,
    required this.universidadActual,
    required this.facultad,
    required this.universidadDestinoId,
    required this.universidadDestinoNombre,
    required this.paisDestino,
    required this.ciudadDestino,
    required this.facultadDestino,
    required this.areaEstudio,
    required this.programaAcademico,
    required this.semestre,
    required this.promedioAcumulado,
    required this.nivelIdioma,
    required this.puntajeIdioma,
    required this.semestreIntercambio,
    required this.fechaViaje,
    required this.fechaRegreso,
  });

  final UsuarioData estudiante;
  final String tipoMovilidad;
  final String nombres;
  final String apellidos;
  final String tipoDocumento;
  final String numeroDocumento;
  final DateTime fechaNacimiento;
  final String emailInstitucional;
  final String emailPersonal;
  final String telefono;
  final String contactoEmergencia;
  final String relacionContacto;
  final String universidadActual;
  final String facultad;
  final String universidadDestinoId;
  final String universidadDestinoNombre;
  final String paisDestino;
  final String ciudadDestino;
  final String facultadDestino;
  final String areaEstudio;
  final String programaAcademico;
  final int semestre;
  final double promedioAcumulado;
  final String nivelIdioma;
  final String puntajeIdioma;
  final String semestreIntercambio;
  final DateTime? fechaViaje;
  final DateTime? fechaRegreso;

  SolicitudMovilidadCompanion toCompanion({String? id}) {
    return SolicitudMovilidadCompanion(
      id: id == null ? const Value.absent() : Value(id),
      estudianteId: Value(estudiante.id),
      tipoMovilidad: Value(tipoMovilidad),
      nombres: Value(nombres),
      apellidos: Value(apellidos),
      tipoDocumento: Value(tipoDocumento),
      numeroDocumento: Value(numeroDocumento),
      fechaNacimiento: Value(fechaNacimiento),
      emailInstitucional: Value(emailInstitucional),
      emailPersonal: Value(emailPersonal),
      telefono: Value(telefono),
      contactoEmergencia: Value(contactoEmergencia),
      relacionContacto: Value(relacionContacto),
      universidadActual: Value(universidadActual),
      facultad: Value(facultad),
      universidadDestinoId: Value(universidadDestinoId),
      universidadDestinoNombre: Value(universidadDestinoNombre),
      paisDestino: Value(paisDestino),
      ciudadDestino: Value(ciudadDestino),
      facultadDestino: Value(facultadDestino),
      areaEstudio: Value(areaEstudio),
      programaAcademico: Value(programaAcademico),
      semestre: Value(semestre),
      promedioAcumulado: Value(promedioAcumulado),
      nivelIdioma: Value(nivelIdioma),
      puntajeIdioma: Value(puntajeIdioma),
      semestreIntercambio: Value(semestreIntercambio),
      fechaViaje: Value(fechaViaje),
      fechaRegreso: Value(fechaRegreso),
      pendingSync: const Value(true),
    );
  }
}

class StudentApplicationRepository {
  StudentApplicationRepository({
    required this.database,
    StudentFirestoreService? remote,
  }) : _remote = remote ?? StudentFirestoreService();

  final AppDatabase database;
  final StudentFirestoreService _remote;
  static final Map<String, Timer> _retryTimers = {};

  Stream<List<SolicitudMobilidadData>> watchMine(String estudianteId) {
    return database.watchSolicitudesDeEstudiante(estudianteId);
  }

  Future<SolicitudMobilidadData?> getById(String id) {
    return database.getSolicitudById(id);
  }

  Future<List<DocumentoData>> getDocuments(String solicitudId) {
    return database.getDocumentosDeSolicitud(solicitudId);
  }

  Stream<List<DocumentoData>> watchDocuments(String solicitudId) {
    return database.watchDocumentosDeSolicitud(solicitudId);
  }

  Stream<List<HistorialEstadoData>> watchHistory(String solicitudId) {
    return database.watchHistorialDeSolicitud(solicitudId);
  }

  Future<String> create(StudentApplicationDraft draft) async {
    final id = await database.crearSolicitud(draft.toCompanion());
    _scheduleSync(id);
    return id;
  }

  Future<void> update(String id, StudentApplicationDraft draft) async {
    await database.actualizarSolicitud(draft.toCompanion(id: id));
    _scheduleSync(id);
  }

  Future<void> submit(String id, UsuarioData estudiante) async {
    final documentos = await database.getDocumentosDeSolicitud(id);
    await database.enviarSolicitud(id, estudiante, documentos);
    _scheduleSync(id);
  }

  Future<void> addDocument({
    required String solicitudId,
    required String tipoDocumento,
    required String nombreArchivo,
  }) async {
    await _ensureDraftIsEditable(solicitudId);
    final documentos = await database.getDocumentosDeSolicitud(solicitudId);
    if (documentos.any(
      (documento) => documento.tipoDocumento == tipoDocumento,
    )) {
      throw StateError('Ya cargaste un documento de este tipo.');
    }
    await database.insertarDocumento(
      DocumentoCompanion.insert(
        id: '',
        solicitudId: solicitudId,
        tipoDocumento: tipoDocumento,
        nombreArchivo: nombreArchivo.trim(),
        fechaSubida: DateTime.now(),
      ),
    );
    _scheduleSync(solicitudId);
  }

  Future<void> deleteDocument(DocumentoData documento) async {
    await _ensureDraftIsEditable(documento.solicitudId);
    await database.eliminarDocumento(documento.id);
    _scheduleSync(documento.solicitudId);
  }

  Future<void> cancel(String id, UsuarioData estudiante) async {
    await database.cancelarSolicitud(id, estudiante);
    _scheduleSync(id);
  }

  Future<void> deleteDraft(String id) async {
    await database.eliminarSolicitud(id);
    unawaited(_deleteRemoteDraft(id));
  }

  Future<void> syncSolicitud(String id) async {
    try {
      final solicitud = await database.getSolicitudById(id);
      if (solicitud == null) {
        _retryTimers.remove(id)?.cancel();
        return;
      }
      final documentos = await database.getDocumentosDeSolicitud(id);
      await _remote
          .upsertSolicitudBundle(solicitud: solicitud, documentos: documentos)
          .timeout(const Duration(seconds: 8));
      unawaited(_deleteRemoteDocumentsMissingLocally(id, documentos));
      await database.marcarSolicitudSincronizada(id);
      await database.marcarDocumentosSolicitudSincronizados(id);
      _retryTimers.remove(id)?.cancel();
    } catch (_) {
      // La solicitud queda marcada como pendiente para reintentar luego.
      _scheduleRetry(id);
    }
  }

  void _scheduleSync(String id) {
    _retryTimers.remove(id)?.cancel();
    Timer.run(() {
      unawaited(syncSolicitud(id));
    });
  }

  void _scheduleRetry(String id) {
    if (_retryTimers.containsKey(id)) return;
    _retryTimers[id] = Timer(const Duration(seconds: 30), () {
      _retryTimers.remove(id);
      unawaited(syncSolicitud(id));
    });
  }

  Future<void> _deleteRemoteDraft(String id) async {
    try {
      await _remote.deleteSolicitud(id).timeout(const Duration(seconds: 8));
    } catch (_) {
      // Si no hay conexion, el borrador local ya fue eliminado.
    }
  }

  Future<void> _deleteRemoteDocumentsMissingLocally(
    String solicitudId,
    List<DocumentoData> documentos,
  ) async {
    try {
      await _remote
          .deleteDocumentosAusentes(
            solicitudId: solicitudId,
            localDocumentoIds: documentos
                .map((documento) => documento.id)
                .toSet(),
          )
          .timeout(const Duration(seconds: 8));
    } catch (_) {
      // La subida principal ya quedo hecha; esta limpieza se reintentara
      // cuando la solicitud vuelva a marcarse pendiente por cambios locales.
    }
  }

  Future<void> _ensureDraftIsEditable(String solicitudId) async {
    final solicitud = await database.getSolicitudById(solicitudId);
    if (solicitud == null) {
      throw StateError('Solicitud no encontrada.');
    }
    if (solicitud.estado != 'borrador' || solicitud.bloqueada) {
      throw StateError(
        'Solo puedes modificar documentos de una solicitud en borrador.',
      );
    }
  }

  Future<void> syncPending() async {
    final pendientes = await database.getSolicitudesPendientesSync();
    for (final solicitud in pendientes) {
      await syncSolicitud(solicitud.id);
    }
  }

  Future<void> syncDown(UsuarioData estudiante) async {
    try {
      final remoteSolicitudes = await _remote
          .fetchSolicitudesDeEstudiante(estudiante.id, estudiante.email)
          .timeout(const Duration(seconds: 8));
      for (final remoteSolicitud in remoteSolicitudes) {
        try {
          await _syncDownSolicitud(remoteSolicitud, estudiante);
        } catch (_) {
          // Si un documento remoto esta incompleto, continuamos con los demas.
        }
      }
    } catch (_) {
      // La app conserva los datos locales si no hay conexion o falla Firestore.
    }
  }

  Future<void> syncAll(UsuarioData estudiante) async {
    await syncPending();
    await syncDown(estudiante);
  }

  Future<void> _syncDownSolicitud(
    SolicitudMovilidadModel remoteSolicitud,
    UsuarioData estudiante,
  ) async {
    final solicitud = remoteSolicitud.estudianteId.trim().isEmpty
        ? remoteSolicitud.copyWith(estudianteId: estudiante.id)
        : remoteSolicitud;
    final localSolicitud = await database.getSolicitudById(solicitud.id);
    if (localSolicitud != null && localSolicitud.pendingSync) {
      return;
    }

    await _upsertSolicitudLocal(solicitud);

    final remoteDocumentos = await _remote
        .fetchDocumentos(solicitud.id)
        .timeout(const Duration(seconds: 8));
    for (final remoteDocumento in remoteDocumentos) {
      await _upsertDocumentoLocal(remoteDocumento);
    }
  }

  Future<void> _upsertSolicitudLocal(SolicitudMovilidadModel solicitud) async {
    await database
        .into(database.solicitudMovilidad)
        .insertOnConflictUpdate(
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
            pendingSync: const Value(false),
          ),
        );
  }

  Future<void> _upsertDocumentoLocal(DocumentoModel documento) async {
    await database
        .into(database.documento)
        .insertOnConflictUpdate(
          DocumentoCompanion.insert(
            id: documento.id,
            solicitudId: documento.solicitudId,
            tipoDocumento: documento.tipoDocumento,
            nombreArchivo: documento.nombreArchivo,
            estado: Value(documento.estado),
            fechaSubida: documento.fechaSubida,
            pendingSync: const Value(false),
          ),
        );
  }
}
