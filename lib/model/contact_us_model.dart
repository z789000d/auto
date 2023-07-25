class ContactUsModel {
  final String companyText;
  final String locationText;
  final String phoneText;
  final String faxText;
  final String emailText;

  ContactUsModel({
    required this.companyText,
    required this.locationText,
    required this.phoneText,
    required this.faxText,
    required this.emailText,
  });

  copyWith(
      {String? companyText,
      String? locationText,
      String? phoneText,
      String? faxText,
      String? emailText}) {
    return ContactUsModel(
        companyText: companyText ?? this.companyText,
        locationText: locationText ?? this.locationText,
        phoneText: phoneText ?? this.phoneText,
        faxText: faxText ?? this.faxText,
        emailText: emailText ?? this.emailText);
  }
}
