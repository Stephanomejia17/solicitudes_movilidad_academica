import 'package:cloud_firestore/cloud_firestore.dart';

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

  SolicitudMovilidadModel copyWith({
    String? id,
    String? estudianteId,
    String? tipoMovilidad,
    DateTime? fechaNacimiento,
    String? emailInstitucional,
    String? emailPersonal,
    String? telefono,
    String? contactoEmergencia,
    String? relacionContacto,
    String? universidadDestinoId,
    String? programaAcademico,
    int? semestre,
    String? estado,
    bool? bloqueada,
    DateTime? fechaCreacion,
    DateTime? fechaActualizacion,
    bool? pendingSync,
  }) {
    return SolicitudMovilidadModel(
      id: id ?? this.id,
      estudianteId: estudianteId ?? this.estudianteId,
      tipoMovilidad: tipoMovilidad ?? this.tipoMovilidad,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      emailInstitucional: emailInstitucional ?? this.emailInstitucional,
      emailPersonal: emailPersonal ?? this.emailPersonal,
      telefono: telefono ?? this.telefono,
      contactoEmergencia: contactoEmergencia ?? this.contactoEmergencia,
      relacionContacto: relacionContacto ?? this.relacionContacto,
      universidadDestinoId: universidadDestinoId ?? this.universidadDestinoId,
      programaAcademico: programaAcademico ?? this.programaAcademico,
      semestre: semestre ?? this.semestre,
      estado: estado ?? this.estado,
      bloqueada: bloqueada ?? this.bloqueada,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      fechaActualizacion: fechaActualizacion ?? this.fechaActualizacion,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'estudianteId': estudianteId,
        'tipoMovilidad': tipoMovilidad,
        'fechaNacimiento': fechaNacimiento.toIso8601String(),
        'emailInstitucional': emailInstitucional,
        'emailPersonal': emailPersonal,
        'telefono': telefono,
        'contactoEmergencia': contactoEmergencia,
        'relacionContacto': relacionContacto,
        'universidadDestinoId': universidadDestinoId,
        'programaAcademico': programaAcademico,
        'semestre': semestre,
        'estado': estado,
        'bloqueada': bloqueada,
        'fechaCreacion': fechaCreacion.toIso8601String(),
        'fechaActualizacion': fechaActualizacion.toIso8601String(),
        'pendingSync': pendingSync,
      };

  factory SolicitudMovilidadModel.fromMap(Map<String, dynamic> map) {
    return SolicitudMovilidadModel(
      id: (map['id'] as String? ?? '').trim(),
      estudianteId: (map['estudianteId'] as String? ?? '').trim(),
      tipoMovilidad: map['tipoMovilidad'] as String? ?? '',
      fechaNacimiento:
          _readDate(map['fechaNacimiento']) ?? DateTime.fromMillisecondsSinceEpoch(0),
      emailInstitucional: map['emailInstitucional'] as String? ?? '',
      emailPersonal: map['emailPersonal'] as String? ?? '',
      telefono: map['telefono'] as String? ?? '',
      contactoEmergencia: map['contactoEmergencia'] as String? ?? '',
      relacionContacto: map['relacionContacto'] as String? ?? '',
      universidadDestinoId: map['universidadDestinoId'] as String? ?? '',
      programaAcademico: map['programaAcademico'] as String? ?? '',
      semestre: (map['semestre'] as num?)?.toInt() ?? 0,
      estado: map['estado'] as String? ?? 'borrador',
      bloqueada: map['bloqueada'] as bool? ?? false,
      fechaCreacion:
          _readDate(map['fechaCreacion']) ?? DateTime.fromMillisecondsSinceEpoch(0),
      fechaActualizacion:
          _readDate(map['fechaActualizacion']) ?? DateTime.fromMillisecondsSinceEpoch(0),
      pendingSync: map['pendingSync'] as bool? ?? false,
    );
  }

  static DateTime? _readDate(Object? value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}

