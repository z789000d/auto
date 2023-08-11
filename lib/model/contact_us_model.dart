class ContactUsRequestModel {
  int action;
  String? companyText;
  String? locationText;
  String? phoneText;
  String? faxText;
  String? emailText;

  ContactUsRequestModel({
    required this.action,
    this.companyText,
    this.locationText,
    this.phoneText,
    this.faxText,
    this.emailText,
  });

  Map<String, dynamic> toJson() {
    return {
      'action': action,
      'companyText': companyText,
      'locationText': locationText,
      'phoneText': phoneText,
      'faxText': faxText,
      'emailText': emailText,
    };
  }
}

class ContactUsResponseModel {
  int? code;
  ContactUsData contactUsData;

  ContactUsResponseModel({
    this.code,
    required this.contactUsData,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'contactUsData': contactUsData.toJson(),
    };
  }

  factory ContactUsResponseModel.fromJson(Map<String, dynamic> json) {
    return ContactUsResponseModel(
      code: json['code'],
      contactUsData: ContactUsData.fromJson(json['data']), // Fix here
    );
  }
}

class ContactUsData {
  String? companyText;
  String? locationText;
  String? phoneText;
  String? faxText;
  String? emailText;

  ContactUsData({
    this.companyText,
    this.locationText,
    this.phoneText,
    this.faxText,
    this.emailText,
  });

  Map<String, dynamic> toJson() {
    return {
      'companyText': companyText,
      'locationText': locationText,
      'phoneText': phoneText,
      'faxText': faxText,
      'emailText': emailText,
    };
  }

  factory ContactUsData.fromJson(Map<String, dynamic> json) {
    return ContactUsData(
      companyText: json['companyText'],
      locationText: json['locationText'],
      phoneText: json['phoneText'],
      faxText: json['faxText'],
      emailText: json['emailText'],
    );
  }
}
