import 'package:cloud_firestore/cloud_firestore.dart';

class SolicitudMovilidadModel {
  const SolicitudMovilidadModel({
    required this.id,
    required this.estudianteId,
    required this.tipoMovilidad,
    required this.nombres,
    required this.apellidos,
    required this.tipoDocumento,
    required this.numeroDocumento,
    required this.fechaNacimiento,
    required this.emailInstitucional,
    required this.emailPersonal,
    required this.telefono,
    required this.contactoEmergencia,
    required this.relacionContacto,
    required this.universidadActual,
    required this.facultad,
    required this.universidadDestinoId,
    required this.universidadDestinoNombre,
    required this.paisDestino,
    required this.ciudadDestino,
    required this.facultadDestino,
    required this.areaEstudio,
    required this.programaAcademico,
    required this.semestre,
    required this.promedioAcumulado,
    required this.nivelIdioma,
    required this.puntajeIdioma,
    required this.semestreIntercambio,
    required this.fechaViaje,
    required this.fechaRegreso,
    required this.estado,
    required this.bloqueada,
    required this.fechaCreacion,
    required this.fechaActualizacion,
    required this.pendingSync,
  });

  final String id;
  final String estudianteId;
  final String tipoMovilidad;
  final String nombres;
  final String apellidos;
  final String tipoDocumento;
  final String numeroDocumento;
  final DateTime fechaNacimiento;
  final String emailInstitucional;
  final String emailPersonal;
  final String telefono;
  final String contactoEmergencia;
  final String relacionContacto;
  final String universidadActual;
  final String facultad;
  final String universidadDestinoId;
  final String universidadDestinoNombre;
  final String paisDestino;
  final String ciudadDestino;
  final String facultadDestino;
  final String areaEstudio;
  final String programaAcademico;
  final int semestre;
  final double promedioAcumulado;
  final String nivelIdioma;
  final String puntajeIdioma;
  final String semestreIntercambio;
  final DateTime? fechaViaje;
  final DateTime? fechaRegreso;
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
    String? nombres,
    String? apellidos,
    String? tipoDocumento,
    String? numeroDocumento,
    DateTime? fechaNacimiento,
    String? emailInstitucional,
    String? emailPersonal,
    String? telefono,
    String? contactoEmergencia,
    String? relacionContacto,
    String? universidadActual,
    String? facultad,
    String? universidadDestinoId,
    String? universidadDestinoNombre,
    String? paisDestino,
    String? ciudadDestino,
    String? facultadDestino,
    String? areaEstudio,
    String? programaAcademico,
    int? semestre,
    double? promedioAcumulado,
    String? nivelIdioma,
    String? puntajeIdioma,
    String? semestreIntercambio,
    DateTime? fechaViaje,
    DateTime? fechaRegreso,
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
      nombres: nombres ?? this.nombres,
      apellidos: apellidos ?? this.apellidos,
      tipoDocumento: tipoDocumento ?? this.tipoDocumento,
      numeroDocumento: numeroDocumento ?? this.numeroDocumento,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      emailInstitucional: emailInstitucional ?? this.emailInstitucional,
      emailPersonal: emailPersonal ?? this.emailPersonal,
      telefono: telefono ?? this.telefono,
      contactoEmergencia: contactoEmergencia ?? this.contactoEmergencia,
      relacionContacto: relacionContacto ?? this.relacionContacto,
      universidadActual: universidadActual ?? this.universidadActual,
      facultad: facultad ?? this.facultad,
      universidadDestinoId: universidadDestinoId ?? this.universidadDestinoId,
      universidadDestinoNombre:
          universidadDestinoNombre ?? this.universidadDestinoNombre,
      paisDestino: paisDestino ?? this.paisDestino,
      ciudadDestino: ciudadDestino ?? this.ciudadDestino,
      facultadDestino: facultadDestino ?? this.facultadDestino,
      areaEstudio: areaEstudio ?? this.areaEstudio,
      programaAcademico: programaAcademico ?? this.programaAcademico,
      semestre: semestre ?? this.semestre,
      promedioAcumulado: promedioAcumulado ?? this.promedioAcumulado,
      nivelIdioma: nivelIdioma ?? this.nivelIdioma,
      puntajeIdioma: puntajeIdioma ?? this.puntajeIdioma,
      semestreIntercambio: semestreIntercambio ?? this.semestreIntercambio,
      fechaViaje: fechaViaje ?? this.fechaViaje,
      fechaRegreso: fechaRegreso ?? this.fechaRegreso,
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
    'nombres': nombres,
    'apellidos': apellidos,
    'tipoDocumento': tipoDocumento,
    'numeroDocumento': numeroDocumento,
    'fechaNacimiento': _dateToString(fechaNacimiento),
    'emailInstitucional': emailInstitucional,
    'emailPersonal': emailPersonal,
    'telefono': telefono,
    'contactoEmergencia': contactoEmergencia,
    'relacionContacto': relacionContacto,
    'universidadActual': universidadActual,
    'facultad': facultad,
    'universidadDestinoId': universidadDestinoId,
    'universidadDestinoNombre': universidadDestinoNombre,
    'paisDestino': paisDestino,
    'ciudadDestino': ciudadDestino,
    'facultadDestino': facultadDestino,
    'areaEstudio': areaEstudio,
    'programaAcademico': programaAcademico,
    'semestre': semestre,
    'promedioAcumulado': promedioAcumulado,
    'nivelIdioma': nivelIdioma,
    'puntajeIdioma': puntajeIdioma,
    'semestreIntercambio': semestreIntercambio,
    'fechaViaje': _dateToString(fechaViaje),
    'fechaRegreso': _dateToString(fechaRegreso),
    'estado': estado,
    'bloqueada': bloqueada,
    'fechaCreacion': _dateToString(fechaCreacion),
    'fechaActualizacion': _dateToString(fechaActualizacion),
    'pendingSync': pendingSync,
  };

  Map<String, dynamic> toFirestore() => {
    'estudianteId': estudianteId,
    'studentId': estudianteId,
    'tipoMovilidad': tipoMovilidad,
    'mobilityType': tipoMovilidad,
    'nombres': nombres,
    'firstName': nombres,
    'apellidos': apellidos,
    'lastName': apellidos,
    'tipoDocumento': tipoDocumento,
    'documentType': tipoDocumento,
    'numeroDocumento': numeroDocumento,
    'documentNumber': numeroDocumento,
    'fechaNacimiento': Timestamp.fromDate(fechaNacimiento),
    'birthDate': Timestamp.fromDate(fechaNacimiento),
    'emailInstitucional': emailInstitucional,
    'institutionalEmail': emailInstitucional,
    'emailPersonal': emailPersonal,
    'personalEmail': emailPersonal,
    'telefono': telefono,
    'phone': telefono,
    'contactoEmergencia': contactoEmergencia,
    'emergencyContact': contactoEmergencia,
    'relacionContacto': relacionContacto,
    'emergencyRelationship': relacionContacto,
    'universidadActual': universidadActual,
    'currentUniversity': universidadActual,
    'facultad': facultad,
    'faculty': facultad,
    'universidadDestinoId': universidadDestinoId,
    'destinationUniversityId': universidadDestinoId,
    'universidadDestinoNombre': universidadDestinoNombre,
    'destinationUniversity': universidadDestinoNombre,
    'paisDestino': paisDestino,
    'country': paisDestino,
    'ciudadDestino': ciudadDestino,
    'city': ciudadDestino,
    'facultadDestino': facultadDestino,
    'destinationFaculty': facultadDestino,
    'areaEstudio': areaEstudio,
    'studyArea': areaEstudio,
    'programaAcademico': programaAcademico,
    'academicProgram': programaAcademico,
    'semestre': semestre,
    'currentSemester': semestre,
    'promedioAcumulado': promedioAcumulado,
    'average': promedioAcumulado,
    'nivelIdioma': nivelIdioma,
    'languageLevel': nivelIdioma,
    'puntajeIdioma': puntajeIdioma,
    'languageScore': puntajeIdioma,
    'semestreIntercambio': semestreIntercambio,
    'exchangeSemester': semestreIntercambio,
    'fechaViaje': fechaViaje == null ? null : Timestamp.fromDate(fechaViaje!),
    'travelDate': fechaViaje == null ? null : Timestamp.fromDate(fechaViaje!),
    'fechaRegreso': fechaRegreso == null
        ? null
        : Timestamp.fromDate(fechaRegreso!),
    'returnDate': fechaRegreso == null
        ? null
        : Timestamp.fromDate(fechaRegreso!),
    'estado': estado,
    'status': estado,
    'bloqueada': bloqueada,
    'locked': bloqueada,
    'fechaCreacion': Timestamp.fromDate(fechaCreacion),
    'createdAt': Timestamp.fromDate(fechaCreacion),
    'fechaActualizacion': Timestamp.fromDate(fechaActualizacion),
    'updatedAt': Timestamp.fromDate(fechaActualizacion),
    'pendingSync': pendingSync,
  };

  factory SolicitudMovilidadModel.fromMap(Map<String, dynamic> map) {
    return SolicitudMovilidadModel(
      id: (map['id'] as String? ?? '').trim(),
      estudianteId: _readString(map, 'estudianteId', 'studentId'),
      tipoMovilidad: _readString(map, 'tipoMovilidad', 'mobilityType'),
      nombres: _readString(map, 'nombres', 'firstName'),
      apellidos: _readString(map, 'apellidos', 'lastName'),
      tipoDocumento: _readString(map, 'tipoDocumento', 'documentType'),
      numeroDocumento: _readString(map, 'numeroDocumento', 'documentNumber'),
      fechaNacimiento:
          _readDate(map['fechaNacimiento'] ?? map['birthDate']) ??
          DateTime.fromMillisecondsSinceEpoch(0),
      emailInstitucional: _readString(
        map,
        'emailInstitucional',
        'institutionalEmail',
      ),
      emailPersonal: _readString(map, 'emailPersonal', 'personalEmail'),
      telefono: _readString(map, 'telefono', 'phone'),
      contactoEmergencia: _readString(
        map,
        'contactoEmergencia',
        'emergencyContact',
      ),
      relacionContacto: _readString(
        map,
        'relacionContacto',
        'emergencyRelationship',
      ),
      universidadActual: _readString(
        map,
        'universidadActual',
        'currentUniversity',
      ),
      facultad: _readString(map, 'facultad', 'faculty'),
      universidadDestinoId: _readString(
        map,
        'universidadDestinoId',
        'destinationUniversityId',
      ),
      universidadDestinoNombre: _readString(
        map,
        'universidadDestinoNombre',
        'destinationUniversity',
      ),
      paisDestino: _readString(map, 'paisDestino', 'country'),
      ciudadDestino: _readString(map, 'ciudadDestino', 'city'),
      facultadDestino: _readString(
        map,
        'facultadDestino',
        'destinationFaculty',
      ),
      areaEstudio: _readString(map, 'areaEstudio', 'studyArea'),
      programaAcademico: _readString(
        map,
        'programaAcademico',
        'academicProgram',
      ),
      semestre: _readInt(map, 'semestre', 'currentSemester'),
      promedioAcumulado: _readDouble(map, 'promedioAcumulado', 'average'),
      nivelIdioma: _readString(map, 'nivelIdioma', 'languageLevel'),
      puntajeIdioma: _readString(map, 'puntajeIdioma', 'languageScore'),
      semestreIntercambio: _readString(
        map,
        'semestreIntercambio',
        'exchangeSemester',
      ),
      fechaViaje: _readDate(map['fechaViaje'] ?? map['travelDate']),
      fechaRegreso: _readDate(map['fechaRegreso'] ?? map['returnDate']),
      estado: _readString(map, 'estado', 'status', fallback: 'borrador'),
      bloqueada: _readBool(map, 'bloqueada', 'locked'),
      fechaCreacion:
          _readDate(map['fechaCreacion'] ?? map['createdAt']) ??
          DateTime.fromMillisecondsSinceEpoch(0),
      fechaActualizacion:
          _readDate(map['fechaActualizacion'] ?? map['updatedAt']) ??
          DateTime.fromMillisecondsSinceEpoch(0),
      pendingSync: map['pendingSync'] as bool? ?? false,
    );
  }

  factory SolicitudMovilidadModel.fromFirestore(
    String docId,
    Map<String, dynamic> map,
  ) {
    return SolicitudMovilidadModel.fromMap({
      ...map,
      'id': docId,
      'pendingSync': false,
    });
  }

  static DateTime? _readDate(Object? value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  static String _readString(
    Map<String, dynamic> map,
    String primary,
    String fallbackKey, {
    String fallback = '',
  }) {
    final value = map[primary] ?? map[fallbackKey];
    return value is String ? value.trim() : fallback;
  }

  static int _readInt(
    Map<String, dynamic> map,
    String primary,
    String fallbackKey,
  ) {
    final value = map[primary] ?? map[fallbackKey];
    return value is num ? value.toInt() : 0;
  }

  static double _readDouble(
    Map<String, dynamic> map,
    String primary,
    String fallbackKey,
  ) {
    final value = map[primary] ?? map[fallbackKey];
    return value is num ? value.toDouble() : 0;
  }

  static bool _readBool(
    Map<String, dynamic> map,
    String primary,
    String fallbackKey,
  ) {
    final value = map[primary] ?? map[fallbackKey];
    return value is bool ? value : false;
  }

  static String? _dateToString(DateTime? value) => value?.toIso8601String();
}
