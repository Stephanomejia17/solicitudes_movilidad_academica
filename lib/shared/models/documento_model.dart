import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentoModel {
  const DocumentoModel({
    required this.id,
    required this.solicitudId,
    required this.tipoDocumento,
    required this.nombreArchivo,
    required this.estado,
    required this.fechaSubida,
    required this.pendingSync,
  });

  final String id;
  final String solicitudId;
  final String tipoDocumento;
  final String nombreArchivo;
  final String estado;
  final DateTime fechaSubida;
  final bool pendingSync;

  DocumentoModel copyWith({
    String? id,
    String? solicitudId,
    String? tipoDocumento,
    String? nombreArchivo,
    String? estado,
    DateTime? fechaSubida,
    bool? pendingSync,
  }) {
    return DocumentoModel(
      id: id ?? this.id,
      solicitudId: solicitudId ?? this.solicitudId,
      tipoDocumento: tipoDocumento ?? this.tipoDocumento,
      nombreArchivo: nombreArchivo ?? this.nombreArchivo,
      estado: estado ?? this.estado,
      fechaSubida: fechaSubida ?? this.fechaSubida,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'solicitudId': solicitudId,
        'tipoDocumento': tipoDocumento,
        'nombreArchivo': nombreArchivo,
        'estado': estado,
        'fechaSubida': fechaSubida.toIso8601String(),
        'pendingSync': pendingSync,
      };

  Map<String, dynamic> toFirestore() => {
        'solicitudId': solicitudId,
        'tipoDocumento': tipoDocumento,
        'nombreArchivo': nombreArchivo,
        'estado': estado,
        'fechaSubida': Timestamp.fromDate(fechaSubida),
        'pendingSync': pendingSync,
      };

  factory DocumentoModel.fromMap(Map<String, dynamic> map) {
    return DocumentoModel(
      id: (map['id'] as String? ?? '').trim(),
      solicitudId: (map['solicitudId'] as String? ?? '').trim(),
      tipoDocumento: map['tipoDocumento'] as String? ?? '',
      nombreArchivo: map['nombreArchivo'] as String? ?? '',
      estado: map['estado'] as String? ?? 'pendiente',
      fechaSubida:
          _readDate(map['fechaSubida']) ?? DateTime.fromMillisecondsSinceEpoch(0),
      pendingSync: map['pendingSync'] as bool? ?? false,
    );
  }

  factory DocumentoModel.fromFirestore(String docId, Map<String, dynamic> map) {
    return DocumentoModel.fromMap({
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
}

