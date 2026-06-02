import 'package:cloud_firestore/cloud_firestore.dart';

class AprobacionModel {
  const AprobacionModel({
    required this.id,
    required this.solicitudId,
    required this.coordinadorId,
    required this.usuarioId,
    required this.decision,
    required this.comentario,
    required this.fechaDecision,
    required this.pendingSync,
  });

  final String id;
  final String solicitudId;
  final String coordinadorId;
  final String usuarioId;
  final String decision;
  final String comentario;
  final DateTime fechaDecision;
  final bool pendingSync;

  AprobacionModel copyWith({
    String? id,
    String? solicitudId,
    String? coordinadorId,
    String? usuarioId,
    String? decision,
    String? comentario,
    DateTime? fechaDecision,
    bool? pendingSync,
  }) {
    return AprobacionModel(
      id: id ?? this.id,
      solicitudId: solicitudId ?? this.solicitudId,
      coordinadorId: coordinadorId ?? this.coordinadorId,
      usuarioId: usuarioId ?? this.usuarioId,
      decision: decision ?? this.decision,
      comentario: comentario ?? this.comentario,
      fechaDecision: fechaDecision ?? this.fechaDecision,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'solicitudId': solicitudId,
        'coordinadorId': coordinadorId,
        'usuarioId': usuarioId,
        'decision': decision,
        'comentario': comentario,
        'fechaDecision': fechaDecision.toIso8601String(),
        'pendingSync': pendingSync,
      };

  factory AprobacionModel.fromMap(Map<String, dynamic> map) {
    return AprobacionModel(
      id: (map['id'] as String? ?? '').trim(),
      solicitudId: (map['solicitudId'] as String? ?? '').trim(),
      coordinadorId: (map['coordinadorId'] as String? ?? '').trim(),
      usuarioId: (map['usuarioId'] as String? ?? '').trim(),
      decision: map['decision'] as String? ?? '',
      comentario: map['comentario'] as String? ?? '',
      fechaDecision:
          _readDate(map['fechaDecision']) ?? DateTime.fromMillisecondsSinceEpoch(0),
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

