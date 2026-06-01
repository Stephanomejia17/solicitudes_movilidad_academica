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

  Map<String, dynamic> toMap() => {
        'id': id,
        'nombre': nombre,
        'pais': pais,
        'ciudad': ciudad,
        'tipoMovilidad': tipoMovilidad,
        'convenioActivo': convenioActivo,
        'pendingSync': pendingSync,
      };
}

