class SolicitudMovilidadModel {
  const SolicitudMovilidadModel({
    required this.id,
    required this.estudianteId,
    required this.tipoMovilidad,
    required this.fechaNacimiento,
    required this.emailInstitucional,
    required this.emailPersonal,
    required this.telefono,
    required this.contactoEmergencia,
    required this.relacionContacto,
    required this.universidadDestinoId,
    required this.programaAcademico,
    required this.semestre,
    required this.estado,
    required this.bloqueada,
    required this.fechaCreacion,
    required this.fechaActualizacion,
    required this.pendingSync,
  });

  final String id;
  final String estudianteId;
  final String tipoMovilidad;
  final DateTime fechaNacimiento;
  final String emailInstitucional;
  final String emailPersonal;
  final String telefono;
  final String contactoEmergencia;
  final String relacionContacto;
  final String universidadDestinoId;
  final String programaAcademico;
  final int semestre;
  final String estado;
  final bool bloqueada;
  final DateTime fechaCreacion;
  final DateTime fechaActualizacion;
  final bool pendingSync;

  bool get isDraft => estado == 'borrador';
  bool get isSubmitted => estado == 'enviada';
}

