import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/app_database.dart';
import '../../../shared/models/models.dart';
import '../../../shared/services/firestore_collections.dart';

class StudentFirestoreService {
  StudentFirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _solicitudes =>
      _firestore.collection(FirestoreCollections.mobilityRequests);

  Future<void> upsertSolicitud(SolicitudMobilidadData solicitud) async {
    await _solicitudes
        .doc(solicitud.id)
        .set(
          _solicitudToModel(solicitud).toFirestoreWithMeta(),
          SetOptions(merge: true),
        );
  }

  Future<void> upsertSolicitudBundle({
    required SolicitudMobilidadData solicitud,
    required List<DocumentoData> documentos,
  }) async {
    final docRef = _solicitudes.doc(solicitud.id);
    final batch = _firestore.batch();

    batch.set(
      docRef,
      _solicitudToModel(solicitud).toFirestoreWithMeta(),
      SetOptions(merge: true),
    );

    for (final documento in documentos) {
      batch.set(
        docRef.collection(FirestoreCollections.documents).doc(documento.id),
        _documentoToModel(documento).toFirestoreWithMeta(),
        SetOptions(merge: true),
      );
    }

    await batch.commit();
  }

  Future<void> deleteDocumentosAusentes({
    required String solicitudId,
    required Set<String> localDocumentoIds,
  }) async {
    final docRef = _solicitudes.doc(solicitudId);
    final remoteDocumentos = await docRef
        .collection(FirestoreCollections.documents)
        .get();
    final batch = _firestore.batch();

    for (final remoteDocumento in remoteDocumentos.docs) {
      if (!localDocumentoIds.contains(remoteDocumento.id)) {
        batch.delete(remoteDocumento.reference);
      }
    }

    await batch.commit();
  }

  Future<void> deleteSolicitud(String id) async {
    await _solicitudes.doc(id).delete();
  }

  Future<List<SolicitudMovilidadModel>> fetchSolicitudesDeEstudiante(
    String estudianteId,
    String email,
  ) async {
    final normalizedEmail = email.trim().toLowerCase();
    final snapshots = <QuerySnapshot<Map<String, dynamic>>>[
      await _solicitudes.where('estudianteId', isEqualTo: estudianteId).get(),
      await _solicitudes.where('studentId', isEqualTo: estudianteId).get(),
    ];

    if (normalizedEmail.isNotEmpty) {
      snapshots.addAll([
        await _solicitudes
            .where('emailInstitucional', isEqualTo: normalizedEmail)
            .get(),
        await _solicitudes
            .where('institutionalEmail', isEqualTo: normalizedEmail)
            .get(),
        await _solicitudes
            .where('emailPersonal', isEqualTo: normalizedEmail)
            .get(),
        await _solicitudes
            .where('personalEmail', isEqualTo: normalizedEmail)
            .get(),
      ]);
    }

    final docsById = {
      for (final snapshot in snapshots)
        for (final doc in snapshot.docs) doc.id: doc,
    };

    final solicitudes =
        docsById.values
            .map(
              (doc) =>
                  SolicitudMovilidadModel.fromFirestore(doc.id, doc.data()),
            )
            .toList()
          ..sort((a, b) => b.fechaCreacion.compareTo(a.fechaCreacion));
    return solicitudes;
  }

  Future<List<DocumentoModel>> fetchDocumentos(String solicitudId) async {
    final snapshot = await _solicitudes
        .doc(solicitudId)
        .collection(FirestoreCollections.documents)
        .get();

    return snapshot.docs
        .map((doc) => DocumentoModel.fromFirestore(doc.id, doc.data()))
        .toList();
  }

  SolicitudMovilidadModel _solicitudToModel(SolicitudMobilidadData solicitud) {
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

  DocumentoModel _documentoToModel(DocumentoData documento) {
    return DocumentoModel(
      id: documento.id,
      solicitudId: documento.solicitudId,
      tipoDocumento: documento.tipoDocumento,
      nombreArchivo: documento.nombreArchivo,
      estado: documento.estado,
      fechaSubida: documento.fechaSubida,
      pendingSync: documento.pendingSync,
    );
  }
}

extension on SolicitudMovilidadModel {
  Map<String, dynamic> toFirestoreWithMeta() => {
    ...toFirestore(),
    'pendingSync': false,
    'updatedAt': FieldValue.serverTimestamp(),
  };
}

extension on DocumentoModel {
  Map<String, dynamic> toFirestoreWithMeta() => {
    ...toFirestore(),
    'pendingSync': false,
    'syncedAt': FieldValue.serverTimestamp(),
  };
}
