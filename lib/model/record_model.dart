import 'package:flutter/material.dart';

enum UserRole { admin, user }

enum ApplicationStatus { pending, approved, rejected }

extension UserRoleX on UserRole {
  String get label => this == UserRole.admin ? 'Admin' : 'User';
}

extension ApplicationStatusX on ApplicationStatus {
  String get label => switch (this) {
    ApplicationStatus.pending => 'Pendiente',
    ApplicationStatus.approved => 'Aprobada',
    ApplicationStatus.rejected => 'Rechazada',
  };

  Color color(BuildContext context) => switch (this) {
    ApplicationStatus.pending => Colors.orange.shade700,
    ApplicationStatus.approved => Colors.green.shade700,
    ApplicationStatus.rejected => Theme.of(context).colorScheme.error,
  };
}

class AppUser {
  AppUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final UserRole role;

  String get fullName => '$firstName $lastName';

  factory AppUser.fromFirestore(Map<String, dynamic> map) {
    return AppUser(
      firstName: map['firstName'] as String? ?? '',
      lastName: map['lastName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      password: map['password'] as String? ?? '',
      role: _userRoleFromString(map['role'] as String?),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'role': role.name,
    };
  }
}

class MobilityApplication {
  MobilityApplication({
    required this.id,
    required this.userEmail,
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    required this.documentType,
    required this.documentNumber,
    required this.birthDate,
    required this.institutionalEmail,
    required this.personalEmail,
    required this.phone,
    required this.emergencyContact,
    required this.relationship,
    required this.currentUniversity,
    required this.faculty,
    required this.program,
    required this.currentSemester,
    required this.average,
    required this.languageLevel,
    required this.languageScore,
    required this.destinationUniversity,
    required this.country,
    required this.city,
    required this.destinationFaculty,
    required this.studyArea,
    required this.exchangeSemester,
    required this.travelDate,
    required this.returnDate,
    this.status = ApplicationStatus.pending,
    this.adminComment = '',
    this.rejectionReason = '',
  });

  final String id;
  final String userEmail;
  final DateTime createdAt;
  final String firstName;
  final String lastName;
  final String documentType;
  final String documentNumber;
  final DateTime birthDate;
  final String institutionalEmail;
  final String personalEmail;
  final String phone;
  final String emergencyContact;
  final String relationship;
  final String currentUniversity;
  final String faculty;
  final String program;
  final int currentSemester;
  final double average;
  final String languageLevel;
  final String languageScore;
  final String destinationUniversity;
  final String country;
  final String city;
  final String destinationFaculty;
  final String studyArea;
  final String exchangeSemester;
  final DateTime travelDate;
  final DateTime returnDate;
  final ApplicationStatus status;
  final String adminComment;
  final String rejectionReason;

  String get studentName => '$firstName $lastName';

  factory MobilityApplication.fromFirestore(
    Map<String, dynamic> map, {
    required String id,
  }) {
    return MobilityApplication(
      id: id,
      userEmail: map['userEmail'] as String? ?? '',
      createdAt: _dateFromMap(map['createdAt']),
      firstName: map['firstName'] as String? ?? '',
      lastName: map['lastName'] as String? ?? '',
      documentType: map['documentType'] as String? ?? '',
      documentNumber: map['documentNumber'] as String? ?? '',
      birthDate: _dateFromMap(map['birthDate']),
      institutionalEmail: map['institutionalEmail'] as String? ?? '',
      personalEmail: map['personalEmail'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      emergencyContact: map['emergencyContact'] as String? ?? '',
      relationship: map['relationship'] as String? ?? '',
      currentUniversity: map['currentUniversity'] as String? ?? '',
      faculty: map['faculty'] as String? ?? '',
      program: map['program'] as String? ?? '',
      currentSemester: (map['currentSemester'] as num?)?.toInt() ?? 0,
      average: (map['average'] as num?)?.toDouble() ?? 0,
      languageLevel: map['languageLevel'] as String? ?? '',
      languageScore: map['languageScore'] as String? ?? '',
      destinationUniversity: map['destinationUniversity'] as String? ?? '',
      country: map['country'] as String? ?? '',
      city: map['city'] as String? ?? '',
      destinationFaculty: map['destinationFaculty'] as String? ?? '',
      studyArea: map['studyArea'] as String? ?? '',
      exchangeSemester: map['exchangeSemester'] as String? ?? '',
      travelDate: _dateFromMap(map['travelDate']),
      returnDate: _dateFromMap(map['returnDate']),
      status: _applicationStatusFromString(map['status'] as String?),
      adminComment: map['adminComment'] as String? ?? '',
      rejectionReason: map['rejectionReason'] as String? ?? '',
    );
  }

  MobilityApplication copyWith({
    String? id,
    String? userEmail,
    DateTime? createdAt,
    String? firstName,
    String? lastName,
    String? documentType,
    String? documentNumber,
    DateTime? birthDate,
    String? institutionalEmail,
    String? personalEmail,
    String? phone,
    String? emergencyContact,
    String? relationship,
    String? currentUniversity,
    String? faculty,
    String? program,
    int? currentSemester,
    double? average,
    String? languageLevel,
    String? languageScore,
    String? destinationUniversity,
    String? country,
    String? city,
    String? destinationFaculty,
    String? studyArea,
    String? exchangeSemester,
    DateTime? travelDate,
    DateTime? returnDate,
    ApplicationStatus? status,
    String? adminComment,
    String? rejectionReason,
  }) {
    return MobilityApplication(
      id: id ?? this.id,
      userEmail: userEmail ?? this.userEmail,
      createdAt: createdAt ?? this.createdAt,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      documentType: documentType ?? this.documentType,
      documentNumber: documentNumber ?? this.documentNumber,
      birthDate: birthDate ?? this.birthDate,
      institutionalEmail: institutionalEmail ?? this.institutionalEmail,
      personalEmail: personalEmail ?? this.personalEmail,
      phone: phone ?? this.phone,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      relationship: relationship ?? this.relationship,
      currentUniversity: currentUniversity ?? this.currentUniversity,
      faculty: faculty ?? this.faculty,
      program: program ?? this.program,
      currentSemester: currentSemester ?? this.currentSemester,
      average: average ?? this.average,
      languageLevel: languageLevel ?? this.languageLevel,
      languageScore: languageScore ?? this.languageScore,
      destinationUniversity:
          destinationUniversity ?? this.destinationUniversity,
      country: country ?? this.country,
      city: city ?? this.city,
      destinationFaculty: destinationFaculty ?? this.destinationFaculty,
      studyArea: studyArea ?? this.studyArea,
      exchangeSemester: exchangeSemester ?? this.exchangeSemester,
      travelDate: travelDate ?? this.travelDate,
      returnDate: returnDate ?? this.returnDate,
      status: status ?? this.status,
      adminComment: adminComment ?? this.adminComment,
      rejectionReason: rejectionReason ?? this.rejectionReason,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userEmail': userEmail,
      'createdAt': createdAt.toIso8601String(),
      'firstName': firstName,
      'lastName': lastName,
      'documentType': documentType,
      'documentNumber': documentNumber,
      'birthDate': birthDate.toIso8601String(),
      'institutionalEmail': institutionalEmail,
      'personalEmail': personalEmail,
      'phone': phone,
      'emergencyContact': emergencyContact,
      'relationship': relationship,
      'currentUniversity': currentUniversity,
      'faculty': faculty,
      'program': program,
      'currentSemester': currentSemester,
      'average': average,
      'languageLevel': languageLevel,
      'languageScore': languageScore,
      'destinationUniversity': destinationUniversity,
      'country': country,
      'city': city,
      'destinationFaculty': destinationFaculty,
      'studyArea': studyArea,
      'exchangeSemester': exchangeSemester,
      'travelDate': travelDate.toIso8601String(),
      'returnDate': returnDate.toIso8601String(),
      'status': status.name,
      'adminComment': adminComment,
      'rejectionReason': rejectionReason,
    };
  }
}

UserRole _userRoleFromString(String? value) {
  return UserRole.values.where((role) => role.name == value).firstOrNull ??
      UserRole.user;
}

ApplicationStatus _applicationStatusFromString(String? value) {
  return ApplicationStatus.values
          .where((status) => status.name == value)
          .firstOrNull ??
      ApplicationStatus.pending;
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
