import 'package:web_auto/model/product_model.dart';

class ProductRequestModel {
  String action;
  int? id;
  int? id1;
  int? id2;
  int? imageId;
  String? imageUrl;
  String? category;
  String? name;
  String? images;
  String? description;
  String? videoLink;
  String? type;

  ProductRequestModel({
    required this.action,
    this.id,
    this.id1,
    this.id2,
    this.imageId,
    this.imageUrl,
    this.category,
    this.name,
    this.images,
    this.description,
    this.videoLink,
    this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'action': action,
      'id': id,
      'id1': id1,
      'id2': id2,
      'imageId': imageId,
      'imageUrl': imageUrl,
      'category': category,
      'name': name,
      'images': images,
      'description': description,
      'videoLink': videoLink,
      'type': type,
    };
  }
}

class ProductResponseModel {
  int code;
  List<ProductPageData> data;

  ProductResponseModel({
    required this.code,
    required this.data,
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductResponseModel(
      code: json['code'],
      data: (json['data'] as List<dynamic>)
          .map((data) => ProductPageData.fromJson(data))
          .toList(),
    );
  }

  ProductResponseModel copyWith({int? code, List<ProductPageData>? data}) {
    return ProductResponseModel(
        code: code ?? this.code, data: data ?? this.data);
  }
}

class ProductPageData {
  int id;
  String category;
  String name;
  String description;
  String videoLink;
  List<ProductImageData> imageData;

  ProductPageData({
    required this.category,
    required this.name,
    required this.imageData,
    required this.description,
    required this.videoLink,
    required this.id,
  });

  factory ProductPageData.fromJson(Map<String, dynamic> json) {
    return ProductPageData(
      category: json['category'],
      name: json['name'],
      imageData: (json['image'] as List<dynamic>)
          .map((data) => ProductImageData.fromJson(data))
          .toList(),
      description: json['description'],
      videoLink: json['videoLink'],
      id: json['id'],
    );
  }
}

class ProductImageData {
  int? id;
  String? imageUrl;
  int? imageId;

  ProductImageData({
    this.id,
    this.imageUrl,
    this.imageId,
  });

  factory ProductImageData.fromJson(Map<String, dynamic> json) {
    return ProductImageData(
      id: json['id'],
      imageUrl: json['imageUrl'],
      imageId: json['imageId'],
    );
  }
}
