import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:web_auto/model/home_page_model.dart';
import 'package:web_auto/model/news_page_model.dart';

class NewsPageApi {
  void postApi(NewsPageRequestModel newsPageRequestModel,
      void Function(NewsPageResponseModel model) callback) async {
    var response = await Dio().post(
      'http://10.42.16.60/api/newsPage.php',
      data: newsPageRequestModel.toJson(),
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    print('postApi ${response.data}');
    callback(NewsPageResponseModel.fromJson(json.decode(response.data)));
  }
}
