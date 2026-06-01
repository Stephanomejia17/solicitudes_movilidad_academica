enum UserRole { student, coordinator, admin }

extension UserRoleX on UserRole {
  String get label => switch (this) {
    UserRole.student => 'Estudiante',
    UserRole.coordinator => 'Coordinador',
    UserRole.admin => 'Administrador',
  };
}

UserRole userRoleFromString(String? value) {
  return UserRole.values.firstWhere(
    (role) => role.name == value,
    orElse: () => UserRole.student,
  );
}
