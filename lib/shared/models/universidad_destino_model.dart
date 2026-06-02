class UniversidadDestinoModel {
  const UniversidadDestinoModel({
    required this.id,
    required this.nombre,
    required this.pais,
    required this.ciudad,
    required this.tipoMovilidad,
    required this.convenioActivo,
    required this.pendingSync,
  });

  final String id;
  final String nombre;
  final String pais;
  final String ciudad;
  final String tipoMovilidad;
  final bool convenioActivo;
  final bool pendingSync;

  UniversidadDestinoModel copyWith({
    String? id,
    String? nombre,
    String? pais,
    String? ciudad,
    String? tipoMovilidad,
    bool? convenioActivo,
    bool? pendingSync,
  }) {
    return UniversidadDestinoModel(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      pais: pais ?? this.pais,
      ciudad: ciudad ?? this.ciudad,
      tipoMovilidad: tipoMovilidad ?? this.tipoMovilidad,
      convenioActivo: convenioActivo ?? this.convenioActivo,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'nombre': nombre,
        'pais': pais,
        'ciudad': ciudad,
        'tipoMovilidad': tipoMovilidad,
        'convenioActivo': convenioActivo,
        'pendingSync': pendingSync,
      };

  factory UniversidadDestinoModel.fromMap(Map<String, dynamic> map) {
    return UniversidadDestinoModel(
      id: (map['id'] as String? ?? '').trim(),
      nombre: map['nombre'] as String? ?? '',
      pais: map['pais'] as String? ?? '',
      ciudad: map['ciudad'] as String? ?? '',
      tipoMovilidad: map['tipoMovilidad'] as String? ?? '',
      convenioActivo: map['convenioActivo'] as bool? ?? true,
      pendingSync: map['pendingSync'] as bool? ?? false,
    );
  }
}

