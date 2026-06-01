import 'package:drift/drift.dart';
import 'package:solicitudes_movilidad_academica/data/app_database.dart';

class RequestWorkflowService {
  const RequestWorkflowService();

  bool canSubmit(
    UsuarioData actor,
    SolicitudMobilidadData solicitud,
    List<DocumentoData> documentos,
  ) {
    if (actor.rol != 'estudiante' || actor.estado != 'activo') {
      return false;
    }
    if (solicitud.estado != 'borrador' || solicitud.bloqueada) {
      return false;
    }
    if (solicitud.universidadDestinoId.trim().isEmpty ||
        solicitud.programaAcademico.trim().isEmpty ||
        solicitud.semestre <= 0) {
      return false;
    }

    final hasMotivation = documentos.any(
      (doc) => doc.tipoDocumento == 'carta_motivacion',
    );
    final hasIdentity = documentos.any(
      (doc) => doc.tipoDocumento == 'documento_identidad',
    );
    return hasMotivation && hasIdentity;
  }

  bool canReview(UsuarioData actor, SolicitudMobilidadData solicitud) {
    return actor.rol == 'coordinador' &&
        actor.estado == 'activo' &&
        (solicitud.estado == 'enviada' || solicitud.estado == 'en_revision');
  }

  SolicitudMovilidadCompanion approve(
    SolicitudMobilidadData solicitud,
    String comentario,
  ) {
    return SolicitudMovilidadCompanion(
      estado: const Value('aprobada'),
      bloqueada: const Value(true),
      fechaActualizacion: Value(DateTime.now()),
      pendingSync: const Value(true),
    );
  }

  SolicitudMovilidadCompanion reject(
    SolicitudMobilidadData solicitud,
    String comentario,
  ) {
    if (comentario.trim().isEmpty) {
      throw ArgumentError('Una solicitud rechazada debe tener un comentario.');
    }

    return SolicitudMovilidadCompanion(
      estado: const Value('rechazada'),
      bloqueada: const Value(true),
      fechaActualizacion: Value(DateTime.now()),
      pendingSync: const Value(true),
    );
  }
}
