import 'package:web_auto/model/product_model.dart';

class NewsPageRequestModel {
  String action;
  int? id;
  String? news;

  NewsPageRequestModel({
    required this.action,
    this.id,
    this.news,
  });

  Map<String, dynamic> toJson() {
    return {
      'action': action,
      'id': id,
      'type': news,
    };
  }
}

class NewsPageResponseModel {
  int code;
  List<NewsData> data;

  NewsPageResponseModel({
    required this.code,
    required this.data,
  });

  factory NewsPageResponseModel.fromJson(Map<String, dynamic> json) {
    return NewsPageResponseModel(
      code: json['code'],
      data: (json['data'] as List<dynamic>)
          .map((data) => NewsData.fromJson(data))
          .toList(),
    );
  }

  NewsPageResponseModel copyWith({int? code, List<NewsData>? data}) {
    return NewsPageResponseModel(
        code: code ?? this.code, data: data ?? this.data);
  }
}

class NewsData {
  int id;
  String news;
  String date;

  NewsData({
    required this.id,
    required this.news,
    required this.date,
  });

  factory NewsData.fromJson(Map<String, dynamic> json) {
    return NewsData(
      id: json['id'],
      news: json['news'],
      date: json['date'],
    );
  }
}
