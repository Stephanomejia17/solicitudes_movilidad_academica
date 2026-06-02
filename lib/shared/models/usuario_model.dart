import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioModel {
  const UsuarioModel({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.rol,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
    required this.pendingSync,
  });

  final String id;
  final String nombre;
  final String apellido;
  final String email;
  final String rol;
  final String estado;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool pendingSync;

  bool get isActive => estado == 'activo';
  String get fullName => '$nombre $apellido'.trim();

  UsuarioModel copyWith({
    String? id,
    String? nombre,
    String? apellido,
    String? email,
    String? rol,
    String? estado,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? pendingSync,
  }) {
    return UsuarioModel(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      email: email ?? this.email,
      rol: rol ?? this.rol,
      estado: estado ?? this.estado,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

    Map<String, dynamic> toFirestore() => {
    'id': id,
    'nombre': nombre,
    'apellido': apellido,
    'email': email,
    'rol': rol,
    'estado': estado,
    'createdAt': Timestamp.fromDate(createdAt),
    'updatedAt': Timestamp.fromDate(updatedAt),
  };

  Map<String, dynamic> toMap() => {
        'id': id,
        'nombre': nombre,
        'apellido': apellido,
        'email': email,
        'rol': rol,
        'estado': estado,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'pendingSync': pendingSync,
      };

   factory UsuarioModel.fromFirestore(String docId, Map<String, dynamic> map) {
    return UsuarioModel.fromMap({
      ...map,
      'id': docId,         // docId = UID de Auth
      'pendingSync': false, // viene de Firestore = ya sincronizado
    });
  }
  
  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      id: (map['id'] as String? ?? '').trim(),
      nombre: map['nombre'] as String? ?? map['firstName'] as String? ?? '',
      apellido:
          map['apellido'] as String? ?? map['lastName'] as String? ?? '',
      email: (map['email'] as String? ?? '').trim().toLowerCase(),
      rol: _normalizeRole(map['rol'] as String? ?? map['role'] as String?),
      estado: _normalizeStatus(map['estado'] as String? ?? map['status'] as String?),
      createdAt: _readDate(map['createdAt']) ?? DateTime.now(),
      updatedAt: _readDate(map['updatedAt']) ?? DateTime.now(),
      pendingSync: map['pendingSync'] as bool? ?? false,
    );
  }

  static String _normalizeRole(String? value) {
    return switch ((value ?? 'estudiante').trim().toLowerCase()) {
      'student' => 'estudiante',
      'coordinator' => 'coordinador',
      'admin' => 'administrador',
      final role => role,
    };
  }

  static String _normalizeStatus(String? value) {
    return switch ((value ?? 'activo').trim().toLowerCase()) {
      'active' => 'activo',
      'inactive' => 'inactivo',
      final status => status,
    };
  }

  static DateTime? _readDate(Object? value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}

