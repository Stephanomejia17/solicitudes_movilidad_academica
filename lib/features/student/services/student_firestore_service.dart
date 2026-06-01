import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/app_database.dart';

class StudentFirestoreService {
  StudentFirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _solicitudes =>
      _firestore.collection('solicitudes_movilidad');

  Future<void> upsertSolicitud(SolicitudMobilidadData solicitud) async {
    await _solicitudes
        .doc(solicitud.id)
        .set(_solicitudToMap(solicitud), SetOptions(merge: true));
  }

  Future<void> deleteSolicitud(String id) async {
    await _solicitudes.doc(id).delete();
  }

  Map<String, dynamic> _solicitudToMap(SolicitudMobilidadData solicitud) {
    return {
      'id': solicitud.id,
      'estudianteId': solicitud.estudianteId,
      'tipoMovilidad': solicitud.tipoMovilidad,
      'nombres': solicitud.nombres,
      'apellidos': solicitud.apellidos,
      'tipoDocumento': solicitud.tipoDocumento,
      'numeroDocumento': solicitud.numeroDocumento,
      'fechaNacimiento': Timestamp.fromDate(solicitud.fechaNacimiento),
      'emailInstitucional': solicitud.emailInstitucional,
      'emailPersonal': solicitud.emailPersonal,
      'telefono': solicitud.telefono,
      'contactoEmergencia': solicitud.contactoEmergencia,
      'relacionContacto': solicitud.relacionContacto,
      'universidadActual': solicitud.universidadActual,
      'facultad': solicitud.facultad,
      'universidadDestinoId': solicitud.universidadDestinoId,
      'universidadDestinoNombre': solicitud.universidadDestinoNombre,
      'paisDestino': solicitud.paisDestino,
      'ciudadDestino': solicitud.ciudadDestino,
      'facultadDestino': solicitud.facultadDestino,
      'areaEstudio': solicitud.areaEstudio,
      'programaAcademico': solicitud.programaAcademico,
      'semestre': solicitud.semestre,
      'promedioAcumulado': solicitud.promedioAcumulado,
      'nivelIdioma': solicitud.nivelIdioma,
      'puntajeIdioma': solicitud.puntajeIdioma,
      'semestreIntercambio': solicitud.semestreIntercambio,
      'fechaViaje': solicitud.fechaViaje == null
          ? null
          : Timestamp.fromDate(solicitud.fechaViaje!),
      'fechaRegreso': solicitud.fechaRegreso == null
          ? null
          : Timestamp.fromDate(solicitud.fechaRegreso!),
      'estado': solicitud.estado,
      'bloqueada': solicitud.bloqueada,
      'fechaCreacion': Timestamp.fromDate(solicitud.fechaCreacion),
      'fechaActualizacion': Timestamp.fromDate(solicitud.fechaActualizacion),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
