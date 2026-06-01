class DestinationUniversity {
  const DestinationUniversity({
    required this.id,
    required this.name,
    required this.country,
    required this.city,
    required this.hasActiveAgreement,
  });

  final String id;
  final String name;
  final String country;
  final String city;
  final bool hasActiveAgreement;

  String get nombre => name;
  String get pais => country;
  String get ciudad => city;
  bool get convenioActivo => hasActiveAgreement;
}
