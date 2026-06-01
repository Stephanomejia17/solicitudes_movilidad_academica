import 'package:drift/drift.dart';

import '../../../data/app_database.dart';
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
  final DateTime fechaViaje;
  final DateTime fechaRegreso;

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

  Stream<List<SolicitudMobilidadData>> watchMine(String estudianteId) {
    return database.watchSolicitudesDeEstudiante(estudianteId);
  }

  Future<SolicitudMobilidadData?> getById(String id) {
    return database.getSolicitudById(id);
  }

  Future<List<DocumentoData>> getDocuments(String solicitudId) {
    return database.getDocumentosDeSolicitud(solicitudId);
  }

  Stream<List<HistorialEstadoData>> watchHistory(String solicitudId) {
    return database.watchHistorialDeSolicitud(solicitudId);
  }

  Future<String> create(StudentApplicationDraft draft) async {
    final id = await database.crearSolicitud(draft.toCompanion());
    await syncSolicitud(id);
    return id;
  }

  Future<void> update(String id, StudentApplicationDraft draft) async {
    await database.actualizarSolicitud(draft.toCompanion(id: id));
    await syncSolicitud(id);
  }

  Future<void> submit(String id, UsuarioData estudiante) async {
    final documentos = await database.getDocumentosDeSolicitud(id);
    await database.enviarSolicitud(id, estudiante, documentos);
    await syncSolicitud(id);
  }

  Future<void> cancel(String id, UsuarioData estudiante) async {
    await database.cancelarSolicitud(id, estudiante);
    await syncSolicitud(id);
  }

  Future<void> deleteDraft(String id) async {
    await database.eliminarSolicitud(id);
    await _remote.deleteSolicitud(id);
  }

  Future<void> syncSolicitud(String id) async {
    final solicitud = await database.getSolicitudById(id);
    if (solicitud == null) return;

    try {
      await _remote.upsertSolicitud(solicitud);
      await database.marcarSolicitudSincronizada(id);
    } catch (_) {
      // La solicitud queda marcada como pendiente para reintentar luego.
    }
  }

  Future<void> syncPending() async {
    final pendientes = await database.getSolicitudesPendientesSync();
    for (final solicitud in pendientes) {
      await syncSolicitud(solicitud.id);
    }
  }
}
