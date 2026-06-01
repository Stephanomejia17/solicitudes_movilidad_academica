import 'user_role.dart';

class AppUser {
  AppUser({
    this.id = '',
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
    this.isActive = true,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final UserRole role;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  String get fullName => '$firstName $lastName';

  String get nombre => firstName;
  String get apellido => lastName;
  String get estado => isActive ? 'activo' : 'inactivo';

  factory AppUser.fromFirestore(Map<String, dynamic> map, {String id = ''}) {
    return AppUser(
      id: id,
      firstName: map['firstName'] as String? ?? map['nombre'] as String? ?? '',
      lastName: map['lastName'] as String? ?? map['apellido'] as String? ?? '',
      email: map['email'] as String? ?? '',
      password: map['password'] as String? ?? '',
      role: userRoleFromString(map['role'] as String? ?? map['rol'] as String?),
      isActive: map['isActive'] as bool? ?? map['estado'] != 'inactivo',
      createdAt: _dateFromMap(map['createdAt']),
      updatedAt: _dateFromMap(map['updatedAt']),
    );
  }

  AppUser copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    UserRole? role,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppUser(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'role': role.name,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

DateTime _dateFromMap(dynamic value) {
  if (value is DateTime) {
    return value;
  }
  if (value is String) {
    return DateTime.tryParse(value) ?? DateTime.now();
  }
  return DateTime.now();
}
