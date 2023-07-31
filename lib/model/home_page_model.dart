import 'package:web_auto/model/product_model.dart';

class HomePageRequestModel {
  String action;
  int? id;
  int? id1;
  int? id2;
  String? category;
  String? name;
  String? images;
  String? description;
  String? videoLink;
  String? type;

  HomePageRequestModel({
    required this.action,
    this.id,
    this.id1,
    this.id2,
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
      'category': category,
      'name': name,
      'images': images,
      'description': description,
      'videoLink': videoLink,
      'type': type,
    };
  }
}

class HomePageResponseModel {
  int code;
  List<ProductData> data;

  HomePageResponseModel({
    required this.code,
    required this.data,
  });

  factory HomePageResponseModel.fromJson(Map<String, dynamic> json) {
    return HomePageResponseModel(
      code: json['code'],
      data: (json['data'] as List<dynamic>)
          .map((data) => ProductData.fromJson(data))
          .toList(),
    );
  }

  HomePageResponseModel copyWith({int? code, List<ProductData>? data}) {
    return HomePageResponseModel(
        code: code ?? this.code, data: data ?? this.data);
  }
}

class ProductData {
  String category;
  String name;
  String images;
  String description;
  String videoLink;
  int id;
  String type;

  ProductData({
    required this.category,
    required this.name,
    required this.images,
    required this.description,
    required this.videoLink,
    required this.id,
    required this.type,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      category: json['category'],
      name: json['name'],
      images: json['images'],
      description: json['description'],
      videoLink: json['videoLink'],
      id: json['id'],
      type: json['type'],
    );
  }
}
