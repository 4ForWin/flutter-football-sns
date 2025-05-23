class AgreementEntity {
  final bool terms;
  final bool privacy;
  final bool location;
  final DateTime agreedAt;

  AgreementEntity({
    required this.terms,
    required this.privacy,
    required this.location,
    required this.agreedAt,
  });
}
