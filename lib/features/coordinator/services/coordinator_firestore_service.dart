import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../shared/models/models.dart';

class CoordinatorFirestoreService {
  CoordinatorFirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _solicitudes =>
      _firestore.collection('solicitudes_movilidad');

  Future<void> upsertSolicitudBundle({
    required SolicitudMovilidadModel solicitud,
    required List<AprobacionModel> aprobaciones,
  }) async {
    final docRef = _solicitudes.doc(solicitud.id);
    final batch = _firestore.batch();

    batch.set(
      docRef,
      {
        ...solicitud.toFirestore(),
        'pendingSync': false,
        'syncedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );

    for (final aprobacion in aprobaciones) {
      batch.set(
        docRef.collection('aprobaciones').doc(aprobacion.id),
        {
          ...aprobacion.toFirestore(),
          'pendingSync': false,
          'syncedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );
    }

    await batch.commit();
  }

  Future<List<SolicitudMovilidadModel>> fetchSolicitudes() async {
    final snapshot = await _solicitudes.orderBy(
      'fechaActualizacion',
      descending: true,
    ).get();

    return snapshot.docs
        .map((doc) => SolicitudMovilidadModel.fromFirestore(doc.id, doc.data()))
        .toList();
  }

  Future<SolicitudMovilidadModel?> fetchSolicitud(String solicitudId) async {
    final doc = await _solicitudes.doc(solicitudId).get();
    if (!doc.exists || doc.data() == null) return null;
    return SolicitudMovilidadModel.fromFirestore(doc.id, doc.data()!);
  }

  Future<List<AprobacionModel>> fetchAprobaciones(String solicitudId) async {
    final snapshot = await _solicitudes
        .doc(solicitudId)
        .collection('aprobaciones')
        .orderBy('fechaDecision', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => AprobacionModel.fromFirestore(doc.id, doc.data()))
        .toList();
  }
}
