import 'package:solicitudes_movilidad_academica/shared/models/models.dart';

class RequestWorkflowService {
  const RequestWorkflowService();

  bool canCreate(AppUser user) =>
      user.role == UserRole.student && user.isActive;

  bool canEdit(AppUser user, MobilityApplication request) {
    return canCreate(user) &&
        request.userEmail == user.email &&
        request.status.canStudentEdit;
  }

  bool canSubmit(AppUser user, MobilityApplication request) {
    return canEdit(user, request) && validateReadyToSubmit(request).isEmpty;
  }

  bool canReview(AppUser user, MobilityApplication request) {
    return user.role == UserRole.coordinator &&
        user.isActive &&
        (request.status == RequestStatus.submitted ||
            request.status == RequestStatus.inReview);
  }

  List<String> validateReadyToSubmit(MobilityApplication request) {
    final errors = <String>[];
    if (request.destinationUniversity.trim().isEmpty) {
      errors.add('Universidad destino');
    }
    if (request.program.trim().isEmpty) {
      errors.add('Programa academico');
    }
    if (request.currentSemester <= 0) {
      errors.add('Semestre');
    }
    if (request.studyArea.trim().isEmpty) {
      errors.add('Carta de motivacion');
    }
    if (request.documentNumber.trim().isEmpty) {
      errors.add('Documento de identidad');
    }
    return errors;
  }

  MobilityApplication submit(MobilityApplication request) {
    _assertTransition(request.status, RequestStatus.submitted);
    return request.copyWith(
      status: RequestStatus.submitted,
      updatedAt: DateTime.now(),
    );
  }

  MobilityApplication approve(MobilityApplication request, String comment) {
    _assertTransition(request.status, RequestStatus.approved);
    return request.copyWith(
      status: RequestStatus.approved,
      adminComment: comment.trim(),
      rejectionReason: '',
      updatedAt: DateTime.now(),
    );
  }

  MobilityApplication reject(
    MobilityApplication request, {
    required String comment,
    required String reason,
  }) {
    if (reason.trim().isEmpty) {
      throw ArgumentError('Una solicitud rechazada debe tener un motivo.');
    }
    _assertTransition(request.status, RequestStatus.rejected);
    return request.copyWith(
      status: RequestStatus.rejected,
      adminComment: comment.trim(),
      rejectionReason: reason.trim(),
      updatedAt: DateTime.now(),
    );
  }

  void _assertTransition(RequestStatus from, RequestStatus to) {
    final allowed = switch (from) {
      RequestStatus.draft => {RequestStatus.submitted, RequestStatus.cancelled},
      RequestStatus.submitted => {
        RequestStatus.inReview,
        RequestStatus.approved,
        RequestStatus.rejected,
        RequestStatus.cancelled,
      },
      RequestStatus.inReview => {
        RequestStatus.approved,
        RequestStatus.rejected,
      },
      RequestStatus.approved => <RequestStatus>{},
      RequestStatus.rejected => <RequestStatus>{},
      RequestStatus.cancelled => <RequestStatus>{},
    };

    if (!allowed.contains(to)) {
      throw StateError('Transicion no permitida: ${from.name} -> ${to.name}');
    }
  }
}
