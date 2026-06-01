import 'package:flutter/material.dart';

enum RequestStatus { draft, submitted, inReview, approved, rejected, cancelled }

extension RequestStatusX on RequestStatus {
  String get label => switch (this) {
    RequestStatus.draft => 'Borrador',
    RequestStatus.submitted => 'Enviada',
    RequestStatus.inReview => 'En revision',
    RequestStatus.approved => 'Aprobada',
    RequestStatus.rejected => 'Rechazada',
    RequestStatus.cancelled => 'Cancelada',
  };

  Color color(BuildContext context) => switch (this) {
    RequestStatus.draft => Colors.blueGrey.shade700,
    RequestStatus.submitted => Colors.orange.shade700,
    RequestStatus.inReview => Colors.indigo.shade700,
    RequestStatus.approved => Colors.green.shade700,
    RequestStatus.rejected => Theme.of(context).colorScheme.error,
    RequestStatus.cancelled => Colors.grey.shade700,
  };

  bool get canStudentEdit => this == RequestStatus.draft;
  bool get isLocked => this == RequestStatus.approved;
}

RequestStatus requestStatusFromString(String? value) {
  return switch (value) {
    'pending' => RequestStatus.submitted,
    'approved' => RequestStatus.approved,
    'rejected' => RequestStatus.rejected,
    _ => RequestStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => RequestStatus.draft,
    ),
  };
}
