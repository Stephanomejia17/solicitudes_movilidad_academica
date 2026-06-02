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
        'tipoMovilidad': tipoMovilidad,
        'nombres': nombres,
        'apellidos': apellidos,
        'tipoDocumento': tipoDocumento,
        'numeroDocumento': numeroDocumento,
        'fechaNacimiento': Timestamp.fromDate(fechaNacimiento),
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
        'fechaViaje': fechaViaje == null ? null : Timestamp.fromDate(fechaViaje!),
        'fechaRegreso':
            fechaRegreso == null ? null : Timestamp.fromDate(fechaRegreso!),
        'estado': estado,
        'bloqueada': bloqueada,
        'fechaCreacion': Timestamp.fromDate(fechaCreacion),
        'fechaActualizacion': Timestamp.fromDate(fechaActualizacion),
        'pendingSync': pendingSync,
      };

  factory SolicitudMovilidadModel.fromMap(Map<String, dynamic> map) {
    return SolicitudMovilidadModel(
      id: (map['id'] as String? ?? '').trim(),
      estudianteId: (map['estudianteId'] as String? ?? '').trim(),
      tipoMovilidad: map['tipoMovilidad'] as String? ?? '',
      nombres: map['nombres'] as String? ?? '',
      apellidos: map['apellidos'] as String? ?? '',
      tipoDocumento: map['tipoDocumento'] as String? ?? '',
      numeroDocumento: map['numeroDocumento'] as String? ?? '',
      fechaNacimiento:
          _readDate(map['fechaNacimiento']) ?? DateTime.fromMillisecondsSinceEpoch(0),
      emailInstitucional: map['emailInstitucional'] as String? ?? '',
      emailPersonal: map['emailPersonal'] as String? ?? '',
      telefono: map['telefono'] as String? ?? '',
      contactoEmergencia: map['contactoEmergencia'] as String? ?? '',
      relacionContacto: map['relacionContacto'] as String? ?? '',
      universidadActual: map['universidadActual'] as String? ?? '',
      facultad: map['facultad'] as String? ?? '',
      universidadDestinoId: map['universidadDestinoId'] as String? ?? '',
      universidadDestinoNombre: map['universidadDestinoNombre'] as String? ?? '',
      paisDestino: map['paisDestino'] as String? ?? '',
      ciudadDestino: map['ciudadDestino'] as String? ?? '',
      facultadDestino: map['facultadDestino'] as String? ?? '',
      areaEstudio: map['areaEstudio'] as String? ?? '',
      programaAcademico: map['programaAcademico'] as String? ?? '',
      semestre: (map['semestre'] as num?)?.toInt() ?? 0,
      promedioAcumulado: (map['promedioAcumulado'] as num?)?.toDouble() ?? 0,
      nivelIdioma: map['nivelIdioma'] as String? ?? '',
      puntajeIdioma: map['puntajeIdioma'] as String? ?? '',
      semestreIntercambio: map['semestreIntercambio'] as String? ?? '',
      fechaViaje: _readDate(map['fechaViaje']),
      fechaRegreso: _readDate(map['fechaRegreso']),
      estado: map['estado'] as String? ?? 'borrador',
      bloqueada: map['bloqueada'] as bool? ?? false,
      fechaCreacion:
          _readDate(map['fechaCreacion']) ?? DateTime.fromMillisecondsSinceEpoch(0),
      fechaActualizacion:
          _readDate(map['fechaActualizacion']) ?? DateTime.fromMillisecondsSinceEpoch(0),
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

  static String? _dateToString(DateTime? value) => value?.toIso8601String();
}

