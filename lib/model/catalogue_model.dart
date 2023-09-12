import 'package:web_auto/model/Catalogue_model.dart';

class CatalogueRequestModel {
  String action;
  int? id;
  int? id1;
  int? id2;
  int? imageId;
  String? imageUrl;
  String? name;
  String? images;

  CatalogueRequestModel({
    required this.action,
    this.id,
    this.id1,
    this.id2,
    this.imageId,
    this.imageUrl,
    this.name,
    this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      'action': action,
      'id': id,
      'id1': id1,
      'id2': id2,
      'imageId': imageId,
      'imageUrl': imageUrl,
      'name': name,
      'images': images,
    };
  }
}

class CatalogueResponseModel {
  int code;
  List<CataloguePageData> data;

  CatalogueResponseModel({
    required this.code,
    required this.data,
  });

  factory CatalogueResponseModel.fromJson(Map<String, dynamic> json) {
    return CatalogueResponseModel(
      code: json['code'],
      data: (json['data'] as List<dynamic>)
          .map((data) => CataloguePageData.fromJson(data))
          .toList(),
    );
  }

  CatalogueResponseModel copyWith({int? code, List<CataloguePageData>? data}) {
    return CatalogueResponseModel(
        code: code ?? this.code, data: data ?? this.data);
  }
}

class CataloguePageData {
  int id;
  String name;
  List<CatalogueImageData> imageData;

  CataloguePageData({
    required this.name,
    required this.imageData,
    required this.id,
  });

  factory CataloguePageData.fromJson(Map<String, dynamic> json) {
    return CataloguePageData(
      name: json['name'],
      imageData: (json['image'] as List<dynamic>)
          .map((data) => CatalogueImageData.fromJson(data))
          .toList(),
      id: json['id'],
    );
  }
}

class CatalogueImageData {
  int? id;
  String? imageUrl;
  int? imageId;

  CatalogueImageData({
    this.id,
    this.imageUrl,
    this.imageId,
  });

  factory CatalogueImageData.fromJson(Map<String, dynamic> json) {
    return CatalogueImageData(
      id: json['id'],
      imageUrl: json['imageUrl'],
      imageId: json['imageId'],
    );
  }
}
