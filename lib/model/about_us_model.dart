class AboutUsRequestModel {
  int action;
  String? imageUrl;
  int? imageId;
  String? newImageUrl;
  int? id1;
  int? id2;
  int? id;
  String? text;

  AboutUsRequestModel({
    required this.action,
    this.imageUrl,
    this.imageId,
    this.newImageUrl,
    this.id1,
    this.id2,
    this.id,
    this.text,
  });

  Map<String, dynamic> toJson() {
    return {
      'action': action,
      'imageUrl': imageUrl,
      'imageId': imageId,
      'newImageUrl': newImageUrl,
      'id1': id1,
      'id2': id2,
      'id': id,
      'text': text,
    };
  }
}

class AboutUsResponseModel {
  int? code;
  AboutUsData aboutUsData;

  AboutUsResponseModel({
    this.code,
    required this.aboutUsData,
  });

  factory AboutUsResponseModel.fromJson(Map<String, dynamic> json) {
    return AboutUsResponseModel(
      code: json['code'],
      aboutUsData: AboutUsData.fromJson(json['data']),
    );
  }
}

class AboutUsData {
  int? id;
  String? text;
  List<AboutUsItemData> imageData;

  AboutUsData({
    this.id,
    this.text,
    required this.imageData,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': text,
      'imageData': imageData,
    };
  }

  factory AboutUsData.fromJson(Map<String, dynamic> json) {
    return AboutUsData(
      id: json['id'],
      text: json['text'],
      imageData: (json['imageData'] as List<dynamic>)
          .map((data) => AboutUsItemData.fromJson(data))
          .toList(),
    );
  }
}

class AboutUsItemData {
  int? id;
  String? imageUrl;
  int? imageId;

  AboutUsItemData({
    this.id,
    this.imageUrl,
    this.imageId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'imageId': imageId,
    };
  }

  factory AboutUsItemData.fromJson(Map<String, dynamic> json) {
    return AboutUsItemData(
      id: json['id'],
      imageUrl: json['imageUrl'],
      imageId: json['imageId'],
    );
  }
}
