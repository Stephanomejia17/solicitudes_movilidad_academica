import 'request_status.dart';

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
    this.status = RequestStatus.draft,
    this.adminComment = '',
    this.rejectionReason = '',
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? createdAt;

  final String id;
  final String userEmail;
  final DateTime createdAt;
  final DateTime updatedAt;
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
  final RequestStatus status;
  final String adminComment;
  final String rejectionReason;

  String get studentName => '$firstName $lastName';
  String get estudianteId => userEmail;
  String get universidadDestinoId => destinationUniversity;
  String get programaAcademico => program;
  int get semestre => currentSemester;
  String get cedula => documentType == 'CC' ? documentNumber : '';
  String get pasaporte => documentType == 'Pasaporte' ? documentNumber : '';
  DateTime get fechaCreacion => createdAt;
  DateTime get fechaActualizacion => updatedAt;

  MobilityApplication copyWith({
    String? id,
    String? userEmail,
    DateTime? createdAt,
    DateTime? updatedAt,
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
    RequestStatus? status,
    String? adminComment,
    String? rejectionReason,
  }) {
    return MobilityApplication(
      id: id ?? this.id,
      userEmail: userEmail ?? this.userEmail,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
}
