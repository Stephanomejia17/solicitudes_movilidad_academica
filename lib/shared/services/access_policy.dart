import 'package:solicitudes_movilidad_academica/data/app_database.dart';

class AccessPolicy {
  const AccessPolicy();

  bool canOpenStudentArea(UsuarioData user) => user.rol == 'estudiante';
  bool canOpenCoordinatorArea(UsuarioData user) => user.rol == 'coordinador';
  bool canOpenAdminArea(UsuarioData user) => user.rol == 'administrador';
}
