class UsuarioModel {
  const UsuarioModel({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.passwordHash,
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
  final String passwordHash;
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
    String? passwordHash,
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
      passwordHash: passwordHash ?? this.passwordHash,
      rol: rol ?? this.rol,
      estado: estado ?? this.estado,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'nombre': nombre,
        'apellido': apellido,
        'email': email,
        'passwordHash': passwordHash,
        'rol': rol,
        'estado': estado,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'pendingSync': pendingSync,
      };
}

