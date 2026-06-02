import '../../../data/app_database.dart';

class CoordinatorReviewPolicy {
  const CoordinatorReviewPolicy();

  bool canReview(UsuarioData actor, SolicitudMobilidadData solicitud) {
    return actor.rol == 'coordinador' &&
        actor.estado == 'activo' &&
        solicitud.estado == 'enviada';
  }

  void ensureCanApprove(
    UsuarioData actor,
    SolicitudMobilidadData solicitud,
  ) {
    if (!canReview(actor, solicitud)) {
      throw StateError(
        'Solo un coordinador activo puede revisar solicitudes enviadas.',
      );
    }
  }

  void ensureCanReject(
    UsuarioData actor,
    SolicitudMobilidadData solicitud, {
    required String motivo,
  }) {
    ensureCanApprove(actor, solicitud);
    if (motivo.trim().isEmpty) {
      throw ArgumentError('El rechazo requiere un motivo obligatorio.');
    }
  }
}
