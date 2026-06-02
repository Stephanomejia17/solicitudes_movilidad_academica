import 'dart:async';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/widgets.dart' show BuildContext, InheritedNotifier;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../shared/services/request_workflow_service.dart';

part 'app_database.g.dart';

@DataClassName('UsuarioData')
class Usuarios extends Table {
  TextColumn get id => text()();
  TextColumn get nombre => text()();
  TextColumn get apellido => text()();
  TextColumn get email => text().unique()();
  TextColumn get rol => text()();
  TextColumn get estado => text().withDefault(const Constant('activo'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DataClassName('SolicitudMobilidadData')
class SolicitudMovilidad extends Table {
  TextColumn get id => text()();
  TextColumn get estudianteId => text()();
  TextColumn get tipoMovilidad => text()();
  TextColumn get nombres => text().withDefault(const Constant(''))();
  TextColumn get apellidos => text().withDefault(const Constant(''))();
  TextColumn get tipoDocumento => text().withDefault(const Constant('CC'))();
  TextColumn get numeroDocumento => text().withDefault(const Constant(''))();
  DateTimeColumn get fechaNacimiento => dateTime()();
  TextColumn get emailInstitucional => text()();
  TextColumn get emailPersonal => text()();
  TextColumn get telefono => text()();
  TextColumn get contactoEmergencia => text()();
  TextColumn get relacionContacto => text()();
  TextColumn get universidadActual =>
      text().withDefault(const Constant('Universidad de Medellin'))();
  TextColumn get facultad => text().withDefault(const Constant(''))();
  TextColumn get universidadDestinoId => text()();
  TextColumn get universidadDestinoNombre =>
      text().withDefault(const Constant(''))();
  TextColumn get paisDestino => text().withDefault(const Constant(''))();
  TextColumn get ciudadDestino => text().withDefault(const Constant(''))();
  TextColumn get facultadDestino => text().withDefault(const Constant(''))();
  TextColumn get areaEstudio => text().withDefault(const Constant(''))();
  TextColumn get programaAcademico => text()();
  IntColumn get semestre => integer()();
  RealColumn get promedioAcumulado => real().withDefault(const Constant(0.0))();
  TextColumn get nivelIdioma => text().withDefault(const Constant(''))();
  TextColumn get puntajeIdioma => text().withDefault(const Constant(''))();
  TextColumn get semestreIntercambio =>
      text().withDefault(const Constant(''))();
  DateTimeColumn get fechaViaje => dateTime().nullable()();
  DateTimeColumn get fechaRegreso => dateTime().nullable()();
  TextColumn get estado => text().withDefault(const Constant('borrador'))();
  BoolColumn get bloqueada => boolean().withDefault(const Constant(false))();
  DateTimeColumn get fechaCreacion => dateTime()();
  DateTimeColumn get fechaActualizacion => dateTime()();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DataClassName('UniversidadDestinoData')
class UniversidadDestino extends Table {
  TextColumn get id => text()();
  TextColumn get nombre => text()();
  TextColumn get pais => text()();
  TextColumn get ciudad => text()();
  TextColumn get tipoMovilidad => text()();
  BoolColumn get convenioActivo =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DataClassName('DocumentoData')
class Documento extends Table {
  TextColumn get id => text()();
  TextColumn get solicitudId => text()();
  TextColumn get tipoDocumento => text()();
  TextColumn get nombreArchivo => text()();
  TextColumn get estado => text().withDefault(const Constant('pendiente'))();
  DateTimeColumn get fechaSubida => dateTime()();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DataClassName('AprobacionData')
class Aprobacion extends Table {
  TextColumn get id => text()();
  TextColumn get solicitudId => text()();
  TextColumn get coordinadorId => text()();
  TextColumn get usuarioId => text()();
  TextColumn get decision => text()();
  TextColumn get comentario => text()();
  DateTimeColumn get fechaDecision => dateTime()();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DataClassName('HistorialEstadoData')
class HistorialEstado extends Table {
  TextColumn get id => text()();
  TextColumn get solicitudId => text().nullable()();
  TextColumn get usuarioId => text()();
  TextColumn get estadoAnterior => text()();
  TextColumn get estadoNuevo => text()();
  TextColumn get comentario => text().nullable()();
  DateTimeColumn get fechaCambio => dateTime()();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Usuarios,
    SolicitudMovilidad,
    UniversidadDestino,
    Documento,
    Aprobacion,
    HistorialEstado,
  ],
)
class AppDatabase extends _$AppDatabase with ChangeNotifier {
  bool _initialized = false;

  AppDatabase([QueryExecutor? executor])
    : super(executor ?? _openConnection()) {
    if (!_initialized) {
      _initialized = true;
      unawaited(_initialize());
    }
  }

  static const _uuid = Uuid();

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 3) {
        await m.addColumn(solicitudMovilidad, solicitudMovilidad.nombres);
        await m.addColumn(solicitudMovilidad, solicitudMovilidad.apellidos);
        await m.addColumn(solicitudMovilidad, solicitudMovilidad.tipoDocumento);
        await m.addColumn(
          solicitudMovilidad,
          solicitudMovilidad.numeroDocumento,
        );
        await m.addColumn(
          solicitudMovilidad,
          solicitudMovilidad.universidadActual,
        );
        await m.addColumn(solicitudMovilidad, solicitudMovilidad.facultad);
        await m.addColumn(
          solicitudMovilidad,
          solicitudMovilidad.universidadDestinoNombre,
        );
        await m.addColumn(solicitudMovilidad, solicitudMovilidad.paisDestino);
        await m.addColumn(solicitudMovilidad, solicitudMovilidad.ciudadDestino);
        await m.addColumn(
          solicitudMovilidad,
          solicitudMovilidad.facultadDestino,
        );
        await m.addColumn(solicitudMovilidad, solicitudMovilidad.areaEstudio);
        await m.addColumn(
          solicitudMovilidad,
          solicitudMovilidad.promedioAcumulado,
        );
        await m.addColumn(solicitudMovilidad, solicitudMovilidad.nivelIdioma);
        await m.addColumn(solicitudMovilidad, solicitudMovilidad.puntajeIdioma);
        await m.addColumn(
          solicitudMovilidad,
          solicitudMovilidad.semestreIntercambio,
        );
        await m.addColumn(solicitudMovilidad, solicitudMovilidad.fechaViaje);
        await m.addColumn(solicitudMovilidad, solicitudMovilidad.fechaRegreso);
      }
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'solicitudes_movilidad_db_v2',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.dart.js'),
      ),
    );
  }

  UsuarioData? currentUser;
  bool isBusy = false;
  String? authError;
  final RequestWorkflowService _workflow = const RequestWorkflowService();

  void setAuthError(String? message) {
    authError = message;
    notifyListeners();
  }

  void setCurrentUser(UsuarioData? user) {
    currentUser = user;
    authError = null;
    notifyListeners();
  }

  Future<UsuarioData?> getUsuarioByEmail(String email) async {
    final normalizedEmail = email.trim().toLowerCase();
    return (select(
      usuarios,
    )..where((t) => t.email.equals(normalizedEmail))).getSingleOrNull();
  }

  Future<UsuarioData?> getUsuarioById(String id) async {
    return (select(usuarios)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<List<UsuarioData>> getAllUsuarios() async {
    return select(usuarios).get();
  }

  Future<void> limpiarUsuariosExcepto(String userId) async {
    await (delete(usuarios)..where((u) => u.id.isNotValue(userId))).go();
  }

  Future<void> upsertUsuarioLocal({
    required String id,
    required String nombre,
    required String apellido,
    required String email,
    required String rol,
    required String estado,
    required DateTime createdAt,
    required DateTime updatedAt,
    required bool pendingSync,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();

    final existing = await getUsuarioById(id);

    if (existing != null) {
      await (update(usuarios)..where((u) => u.id.equals(id))).write(
        UsuariosCompanion(
          nombre: Value(nombre.trim()),
          apellido: Value(apellido.trim()),
          email: Value(normalizedEmail),
          rol: Value(rol.trim()),
          estado: Value(estado),
          updatedAt: Value(updatedAt),
          pendingSync: Value(pendingSync),
        ),
      );

      return;
    }

    await into(usuarios).insert(
      UsuariosCompanion.insert(
        id: id,
        nombre: nombre.trim(),
        apellido: apellido.trim(),
        email: normalizedEmail,
        rol: rol.trim(),
        estado: Value(estado),
        createdAt: createdAt,
        updatedAt: updatedAt,
        pendingSync: Value(pendingSync),
      ),
    );
  }

  Future<void> marcarUsuarioSincronizado(String id) async {
    await (update(usuarios)..where((t) => t.id.equals(id))).write(
      const UsuariosCompanion(pendingSync: Value(false)),
    );
  }

  Future<List<UsuarioData>> getUsuariosPendientesSync() async {
    return (select(usuarios)..where((t) => t.pendingSync.equals(true))).get();
  }

  Stream<List<UsuarioData>> watchUsuarios() {
    return select(usuarios).watch();
  }

  Future<void> updateUsuario(UsuariosCompanion companion) async {
    if (!companion.id.present) {
      throw ArgumentError('El id del usuario es obligatorio para actualizar.');
    }

    final id = companion.id.value;
    final existing = await getUsuarioById(id);
    if (existing == null) {
      throw StateError('Usuario no encontrado.');
    }

    final updated = existing.copyWith(
      nombre: companion.nombre.present
          ? companion.nombre.value
          : existing.nombre,
      apellido: companion.apellido.present
          ? companion.apellido.value
          : existing.apellido,
      email: companion.email.present ? companion.email.value : existing.email,
      //passwordHash: companion.passwordHash.present
      //? companion.passwordHash.value
      //: existing.passwordHash,
      rol: companion.rol.present ? companion.rol.value : existing.rol,
      estado: companion.estado.present
          ? companion.estado.value
          : existing.estado,
      updatedAt: DateTime.now(),
      pendingSync: companion.pendingSync.present
          ? companion.pendingSync.value
          : existing.pendingSync,
    );

    await update(usuarios).replace(updated);
  }

  Future<void> setUsuarioEstado(String id, String estado) async {
    final existing = await getUsuarioById(id);
    if (existing == null) return;

    await (update(usuarios)..where((t) => t.id.equals(id))).write(
      UsuariosCompanion(
        estado: Value(estado),
        updatedAt: Value(DateTime.now()),
        pendingSync: const Value(true),
      ),
    );
  }

  Stream<List<SolicitudMobilidadData>> watchSolicitudes() {
    return (select(
      solicitudMovilidad,
    )..orderBy([(t) => OrderingTerm.desc(t.fechaCreacion)])).watch();
  }

  Stream<List<SolicitudMobilidadData>> watchSolicitudesDeEstudiante(
    String estudianteId,
  ) {
    return (select(solicitudMovilidad)
          ..where((t) => t.estudianteId.equals(estudianteId))
          ..orderBy([(t) => OrderingTerm.desc(t.fechaCreacion)]))
        .watch();
  }

  Future<List<SolicitudMobilidadData>> getAllSolicitudes() async {
    return (select(
      solicitudMovilidad,
    )..orderBy([(t) => OrderingTerm.desc(t.fechaCreacion)])).get();
  }

  Future<SolicitudMobilidadData?> getSolicitudById(String id) async {
    return (select(
      solicitudMovilidad,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<String> crearSolicitud(SolicitudMovilidadCompanion companion) async {
    final now = DateTime.now();
    final id = _uuid.v4();
    await into(solicitudMovilidad).insert(
      companion.copyWith(
        id: Value(id),
        estado: const Value('borrador'),
        bloqueada: const Value(false),
        fechaCreacion: Value(now),
        fechaActualizacion: Value(now),
        pendingSync: const Value(true),
      ),
    );
    notifyListeners();
    return id;
  }

  Future<void> actualizarSolicitud(
    SolicitudMovilidadCompanion companion,
  ) async {
    final id = companion.id.present ? companion.id.value : null;
    if (id == null) {
      throw ArgumentError(
        'El id de la solicitud es obligatorio para actualizar.',
      );
    }

    final existing = await getSolicitudById(id);
    if (existing == null) {
      throw StateError('Solicitud no encontrada.');
    }
    if (existing.estado != 'borrador' || existing.bloqueada) {
      throw StateError('Solo una solicitud en borrador puede editarse.');
    }

    await (update(solicitudMovilidad)..where((t) => t.id.equals(id))).write(
      SolicitudMovilidadCompanion(
        estudianteId: companion.estudianteId,
        tipoMovilidad: companion.tipoMovilidad,
        nombres: companion.nombres,
        apellidos: companion.apellidos,
        tipoDocumento: companion.tipoDocumento,
        numeroDocumento: companion.numeroDocumento,
        fechaNacimiento: companion.fechaNacimiento,
        emailInstitucional: companion.emailInstitucional,
        emailPersonal: companion.emailPersonal,
        telefono: companion.telefono,
        contactoEmergencia: companion.contactoEmergencia,
        relacionContacto: companion.relacionContacto,
        universidadActual: companion.universidadActual,
        facultad: companion.facultad,
        universidadDestinoId: companion.universidadDestinoId,
        universidadDestinoNombre: companion.universidadDestinoNombre,
        paisDestino: companion.paisDestino,
        ciudadDestino: companion.ciudadDestino,
        facultadDestino: companion.facultadDestino,
        areaEstudio: companion.areaEstudio,
        programaAcademico: companion.programaAcademico,
        semestre: companion.semestre,
        promedioAcumulado: companion.promedioAcumulado,
        nivelIdioma: companion.nivelIdioma,
        puntajeIdioma: companion.puntajeIdioma,
        semestreIntercambio: companion.semestreIntercambio,
        fechaViaje: companion.fechaViaje,
        fechaRegreso: companion.fechaRegreso,
        fechaActualizacion: Value(DateTime.now()),
        pendingSync: const Value(true),
      ),
    );
    notifyListeners();
  }

  Future<void> enviarSolicitud(
    String id,
    UsuarioData actor,
    List<DocumentoData> documentos,
  ) async {
    final solicitud = await getSolicitudById(id);
    if (solicitud == null) {
      throw StateError('Solicitud no encontrada.');
    }

    // Validaciones específicas con mensajes claros para el usuario
    if (actor.rol != 'estudiante' || actor.estado != 'activo') {
      throw StateError('Solo un estudiante activo puede enviar la solicitud.');
    }
    if (solicitud.estado != 'borrador' || solicitud.bloqueada) {
      throw StateError('Solo una solicitud en borrador puede enviarse.');
    }
    if (solicitud.universidadDestinoId.trim().isEmpty) {
      throw StateError('Debes seleccionar una universidad destino.');
    }
    if (solicitud.programaAcademico.trim().isEmpty) {
      throw StateError('El programa académico es obligatorio.');
    }
    if (solicitud.semestre <= 0) {
      throw StateError('El semestre debe ser mayor a cero.');
    }
    if (!documentos.any((d) => d.tipoDocumento == 'carta_motivacion')) {
      throw StateError('Debes cargar la carta de motivación.');
    }
    if (!documentos.any((d) => d.tipoDocumento == 'documento_identidad')) {
      throw StateError('Debes cargar el documento de identidad.');
    }

    await transaction(() async {
      await (update(solicitudMovilidad)..where((t) => t.id.equals(id))).write(
        SolicitudMovilidadCompanion(
          estado: const Value('enviada'),
          bloqueada: const Value(true),
          fechaActualizacion: Value(DateTime.now()),
          pendingSync: const Value(true),
        ),
      );
      await _registrarCambioEstado(
        solicitudId: id,
        usuarioId: actor.id,
        estadoAnterior: solicitud.estado,
        estadoNuevo: 'enviada',
        comentario: 'Solicitud enviada por el estudiante.',
      );
    });
  }

  Future<void> revisarSolicitud({
    required String id,
    required String decision,
    required String comentario,
    required UsuarioData coordinador,
  }) async {
    final solicitud = await getSolicitudById(id);
    if (solicitud == null) {
      throw StateError('Solicitud no encontrada.');
    }
    if (!_workflow.canReview(coordinador, solicitud)) {
      throw StateError('Solo un coordinador puede revisar esta solicitud.');
    }
    if (decision != 'aprobada' && decision != 'rechazada') {
      throw ArgumentError('Decision invalida.');
    }
    if (decision == 'rechazada' && comentario.trim().isEmpty) {
      throw ArgumentError('Una solicitud rechazada debe tener comentario.');
    }

    await transaction(() async {
      await into(aprobacion).insert(
        AprobacionCompanion.insert(
          id: _uuid.v4(),
          solicitudId: id,
          coordinadorId: coordinador.id,
          usuarioId: solicitud.estudianteId,
          decision: decision,
          comentario: comentario.trim(),
          fechaDecision: DateTime.now(),
          pendingSync: const Value(true),
        ),
      );

      await (update(solicitudMovilidad)..where((t) => t.id.equals(id))).write(
        SolicitudMovilidadCompanion(
          estado: Value(decision),
          bloqueada: const Value(true),
          fechaActualizacion: Value(DateTime.now()),
          pendingSync: const Value(true),
        ),
      );
      await _registrarCambioEstado(
        solicitudId: id,
        usuarioId: coordinador.id,
        estadoAnterior: solicitud.estado,
        estadoNuevo: decision,
        comentario: comentario.trim(),
      );
    });
  }

  Future<void> cancelarSolicitud(String id, UsuarioData actor) async {
    final solicitud = await getSolicitudById(id);
    if (solicitud == null) return;
    if (solicitud.estado == 'aprobada') {
      throw StateError('Una solicitud aprobada no puede cancelarse.');
    }

    await transaction(() async {
      await (update(solicitudMovilidad)..where((t) => t.id.equals(id))).write(
        SolicitudMovilidadCompanion(
          estado: const Value('cancelada'),
          bloqueada: const Value(true),
          fechaActualizacion: Value(DateTime.now()),
          pendingSync: const Value(true),
        ),
      );
      await _registrarCambioEstado(
        solicitudId: id,
        usuarioId: actor.id,
        estadoAnterior: solicitud.estado,
        estadoNuevo: 'cancelada',
        comentario: 'Solicitud cancelada.',
      );
    });
  }

  Future<void> eliminarSolicitud(String id) async {
    final solicitud = await getSolicitudById(id);
    if (solicitud == null) return;
    if (solicitud.estado != 'borrador') {
      throw StateError('Solo las solicitudes en borrador pueden eliminarse.');
    }
    await (delete(solicitudMovilidad)..where((t) => t.id.equals(id))).go();
  }

  Future<void> marcarSolicitudSincronizada(String id) async {
    await (update(solicitudMovilidad)..where((t) => t.id.equals(id))).write(
      const SolicitudMovilidadCompanion(pendingSync: Value(false)),
    );
  }

  Future<void> marcarSolicitudPendienteSync(String id) async {
    await (update(solicitudMovilidad)..where((t) => t.id.equals(id))).write(
      SolicitudMovilidadCompanion(
        fechaActualizacion: Value(DateTime.now()),
        pendingSync: const Value(true),
      ),
    );
  }

  Future<List<SolicitudMobilidadData>> getSolicitudesPendientesSync() async {
    return (select(
      solicitudMovilidad,
    )..where((t) => t.pendingSync.equals(true))).get();
  }

  Future<List<UniversidadDestinoData>> getAllUniversidades() async {
    return select(universidadDestino).get();
  }

  Stream<List<UniversidadDestinoData>> watchUniversidades() {
    return select(universidadDestino).watch();
  }

  Future<UniversidadDestinoData?> getUniversidadById(String id) async {
    return (select(
      universidadDestino,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<void> insertarUniversidad(
    UniversidadDestinoCompanion companion,
  ) async {
    await into(universidadDestino).insert(
      companion.copyWith(
        id: Value(_uuid.v4()),
        convenioActivo: companion.convenioActivo.present
            ? companion.convenioActivo
            : const Value(true),
        pendingSync: const Value(true),
      ),
    );
  }

  Future<void> actualizarUniversidad(
    UniversidadDestinoCompanion companion,
  ) async {
    final id = companion.id.present ? companion.id.value : null;
    if (id == null) {
      throw ArgumentError('El id de la universidad es obligatorio.');
    }
    final existing = await getUniversidadById(id);
    if (existing == null) {
      throw StateError('Universidad no encontrada.');
    }

    final updated = existing.copyWith(
      nombre: companion.nombre.present
          ? companion.nombre.value
          : existing.nombre,
      pais: companion.pais.present ? companion.pais.value : existing.pais,
      ciudad: companion.ciudad.present
          ? companion.ciudad.value
          : existing.ciudad,
      tipoMovilidad: companion.tipoMovilidad.present
          ? companion.tipoMovilidad.value
          : existing.tipoMovilidad,
      convenioActivo: companion.convenioActivo.present
          ? companion.convenioActivo.value
          : existing.convenioActivo,
      pendingSync: companion.pendingSync.present
          ? companion.pendingSync.value
          : existing.pendingSync,
    );

    await update(universidadDestino).replace(updated);
  }

  Future<List<DocumentoData>> getDocumentosDeSolicitud(
    String solicitudId,
  ) async {
    return (select(documento)
          ..where((t) => t.solicitudId.equals(solicitudId))
          ..orderBy([(t) => OrderingTerm.desc(t.fechaSubida)]))
        .get();
  }

  Stream<List<DocumentoData>> watchDocumentosDeSolicitud(String solicitudId) {
    return (select(documento)
          ..where((t) => t.solicitudId.equals(solicitudId))
          ..orderBy([(t) => OrderingTerm.desc(t.fechaSubida)]))
        .watch();
  }

  Future<void> insertarDocumento(DocumentoCompanion companion) async {
    final solicitudId = companion.solicitudId.value;
    await transaction(() async {
      await into(documento).insert(
        DocumentoCompanion.insert(
          id: _uuid.v4(),
          solicitudId: solicitudId,
          tipoDocumento: companion.tipoDocumento.value,
          nombreArchivo: companion.nombreArchivo.value,
          estado: const Value('pendiente'),
          fechaSubida: companion.fechaSubida.present
              ? companion.fechaSubida.value
              : DateTime.now(),
          pendingSync: const Value(true),
        ),
      );
      await marcarSolicitudPendienteSync(solicitudId);
    });
    notifyListeners();
  }

  Future<void> actualizarDocumento(DocumentoCompanion companion) async {
    final id = companion.id.present ? companion.id.value : null;
    if (id == null) {
      throw ArgumentError('El id del documento es obligatorio.');
    }
    final existing = await (select(
      documento,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    if (existing == null) {
      throw StateError('Documento no encontrado.');
    }

    final updated = existing.copyWith(
      solicitudId: companion.solicitudId.present
          ? companion.solicitudId.value
          : existing.solicitudId,
      tipoDocumento: companion.tipoDocumento.present
          ? companion.tipoDocumento.value
          : existing.tipoDocumento,
      nombreArchivo: companion.nombreArchivo.present
          ? companion.nombreArchivo.value
          : existing.nombreArchivo,
      estado: companion.estado.present
          ? companion.estado.value
          : existing.estado,
      fechaSubida: companion.fechaSubida.present
          ? companion.fechaSubida.value
          : existing.fechaSubida,
      pendingSync: companion.pendingSync.present
          ? companion.pendingSync.value
          : existing.pendingSync,
    );

    await update(documento).replace(updated);
  }

  Future<void> eliminarDocumento(String id) async {
    final existing = await (select(
      documento,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    if (existing == null) return;

    await transaction(() async {
      await (delete(documento)..where((t) => t.id.equals(id))).go();
      await marcarSolicitudPendienteSync(existing.solicitudId);
    });
    notifyListeners();
  }

  Future<void> marcarDocumentosSolicitudSincronizados(
    String solicitudId,
  ) async {
    await (update(documento)..where((t) => t.solicitudId.equals(solicitudId)))
        .write(const DocumentoCompanion(pendingSync: Value(false)));
  }

  Future<List<HistorialEstadoData>> getHistorialDeSolicitud(
    String solicitudId,
  ) async {
    return (select(historialEstado)
          ..where((t) => t.solicitudId.equals(solicitudId))
          ..orderBy([(t) => OrderingTerm.desc(t.fechaCambio)]))
        .get();
  }

  Stream<List<HistorialEstadoData>> watchHistorialDeSolicitud(
    String solicitudId,
  ) {
    return (select(historialEstado)
          ..where((t) => t.solicitudId.equals(solicitudId))
          ..orderBy([(t) => OrderingTerm.desc(t.fechaCambio)]))
        .watch();
  }

  Future<void> _registrarCambioEstado({
    required String solicitudId,
    required String usuarioId,
    required String estadoAnterior,
    required String estadoNuevo,
    String? comentario,
  }) async {
    await into(historialEstado).insert(
      HistorialEstadoCompanion.insert(
        id: _uuid.v4(),
        solicitudId: Value(solicitudId),
        usuarioId: usuarioId,
        estadoAnterior: estadoAnterior,
        estadoNuevo: estadoNuevo,
        comentario: Value(comentario),
        fechaCambio: DateTime.now(),
        pendingSync: const Value(true),
      ),
    );
  }

  Future<List<AprobacionData>> getAprobacionesDeSolicitud(
    String solicitudId,
  ) async {
    return (select(aprobacion)
          ..where((t) => t.solicitudId.equals(solicitudId))
          ..orderBy([(t) => OrderingTerm.desc(t.fechaDecision)]))
        .get();
  }

  Future<AprobacionData?> getUltimaAprobacion(String solicitudId) async {
    return (select(aprobacion)
          ..where((t) => t.solicitudId.equals(solicitudId))
          ..orderBy([(t) => OrderingTerm.desc(t.fechaDecision)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<void> _initialize() async {
    await _seedDemoDataIfNeeded();
    notifyListeners();
  }

  Future<void> _seedDemoDataIfNeeded() async {
    final hasUniversidades = await (select(
      universidadDestino,
    )..limit(1)).getSingleOrNull();
    if (hasUniversidades == null) {
      await batch((batch) {
        batch.insertAll(universidadDestino, [
          UniversidadDestinoCompanion.insert(
            id: _uuid.v4(),
            nombre: 'Universidad de Valencia',
            pais: 'España',
            ciudad: 'Valencia',
            tipoMovilidad: 'internacional',
            convenioActivo: const Value(true),
            pendingSync: const Value(true),
          ),
          UniversidadDestinoCompanion.insert(
            id: _uuid.v4(),
            nombre: 'Universidad de Buenos Aires',
            pais: 'Argentina',
            ciudad: 'Buenos Aires',
            tipoMovilidad: 'internacional',
            convenioActivo: const Value(true),
            pendingSync: const Value(true),
          ),
          UniversidadDestinoCompanion.insert(
            id: _uuid.v4(),
            nombre: 'Universidad Nacional de Colombia',
            pais: 'Colombia',
            ciudad: 'Bogotá',
            tipoMovilidad: 'nacional',
            convenioActivo: const Value(true),
            pendingSync: const Value(true),
          ),
        ]);
      });
    }
  }

  // Métodos para historial de usuarios (cambios de estado, asignación de roles)
  Future<void> registrarCambioEstadoUsuario({
    required String usuarioId,
    required String estadoAnterior,
    required String estadoNuevo,
    String? comentario,
    required String registradoPor,
  }) async {
    await into(historialEstado).insert(
      HistorialEstadoCompanion.insert(
        id: _uuid.v4(),
        solicitudId: const Value.absent(),
        usuarioId: usuarioId,
        estadoAnterior: estadoAnterior,
        estadoNuevo: estadoNuevo,
        comentario: Value(comentario),
        fechaCambio: DateTime.now(),
        pendingSync: const Value(true),
      ),
    );
  }

  Future<List<HistorialEstadoData>> getHistorialDeUsuario(
    String usuarioId,
  ) async {
    return (select(historialEstado)
          ..where((t) => t.usuarioId.equals(usuarioId))
          ..orderBy([(t) => OrderingTerm.desc(t.fechaCambio)]))
        .get();
  }

  Stream<List<HistorialEstadoData>> watchHistorialDeUsuario(String usuarioId) {
    return (select(historialEstado)
          ..where((t) => t.usuarioId.equals(usuarioId))
          ..orderBy([(t) => OrderingTerm.desc(t.fechaCambio)]))
        .watch();
  }

  Future<List<HistorialEstadoData>> getHistorialPendientesSync() async {
    return (select(historialEstado)
          ..where((t) => t.pendingSync.equals(true))
          ..where((t) => t.solicitudId.isNull()))
        .get();
  }

  Future<void> marcarHistorialSincronizado(String id) async {
    await (update(historialEstado)..where((t) => t.id.equals(id))).write(
      const HistorialEstadoCompanion(pendingSync: Value(false)),
    );
  }
}

class AppStateScope extends InheritedNotifier<AppDatabase> {
  const AppStateScope({
    super.key,
    required AppDatabase state,
    required super.child,
  }) : super(notifier: state);

  static AppDatabase of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'AppStateScope no encontrado en el arbol.');
    return scope!.notifier!;
  }
}
