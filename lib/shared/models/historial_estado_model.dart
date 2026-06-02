import 'package:cloud_firestore/cloud_firestore.dart';

class HistorialEstadoModel {
  const HistorialEstadoModel({
    required this.id,
    required this.solicitudId,
    required this.usuarioId,
    required this.estadoAnterior,
    required this.estadoNuevo,
    required this.fechaCambio,
    required this.pendingSync,
    this.comentario,
  });

  final String id;
  final String solicitudId;
  final String usuarioId;
  final String estadoAnterior;
  final String estadoNuevo;
  final String? comentario;
  final DateTime fechaCambio;
  final bool pendingSync;

  HistorialEstadoModel copyWith({
    String? id,
    String? solicitudId,
    String? usuarioId,
    String? estadoAnterior,
    String? estadoNuevo,
    String? comentario,
    DateTime? fechaCambio,
    bool? pendingSync,
  }) {
    return HistorialEstadoModel(
      id: id ?? this.id,
      solicitudId: solicitudId ?? this.solicitudId,
      usuarioId: usuarioId ?? this.usuarioId,
      estadoAnterior: estadoAnterior ?? this.estadoAnterior,
      estadoNuevo: estadoNuevo ?? this.estadoNuevo,
      comentario: comentario ?? this.comentario,
      fechaCambio: fechaCambio ?? this.fechaCambio,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'solicitudId': solicitudId,
        'usuarioId': usuarioId,
        'estadoAnterior': estadoAnterior,
        'estadoNuevo': estadoNuevo,
        'comentario': comentario,
        'fechaCambio': fechaCambio.toIso8601String(),
        'pendingSync': pendingSync,
      };

  factory HistorialEstadoModel.fromMap(Map<String, dynamic> map) {
    return HistorialEstadoModel(
      id: (map['id'] as String? ?? '').trim(),
      solicitudId: (map['solicitudId'] as String? ?? '').trim(),
      usuarioId: (map['usuarioId'] as String? ?? '').trim(),
      estadoAnterior: map['estadoAnterior'] as String? ?? '',
      estadoNuevo: map['estadoNuevo'] as String? ?? '',
      comentario: map['comentario'] as String?,
      fechaCambio:
          _readDate(map['fechaCambio']) ?? DateTime.fromMillisecondsSinceEpoch(0),
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

