import 'package:solicitudes_movilidad_academica/shared/models/models.dart';

class AccessPolicy {
  const AccessPolicy();

  bool canOpenStudentArea(AppUser user) => user.role == UserRole.student;
  bool canOpenCoordinatorArea(AppUser user) =>
      user.role == UserRole.coordinator;
  bool canOpenAdminArea(AppUser user) => user.role == UserRole.admin;
}
