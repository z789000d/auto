import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:web_auto/model/home_page_model.dart';
import 'package:web_auto/model/news_page_model.dart';

import '../model/about_us_model.dart';

class AboutUsPageApi {
  void postApi(AboutUsRequestModel aboutUsPageRequestModel,
      void Function(AboutUsResponseModel model) callback) async {
    var response = await Dio().post(
      'http://10.42.16.60/api/aboutUsPage.php',
      data: aboutUsPageRequestModel.toJson(),
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    print('postApi ${response.data}');
    callback(AboutUsResponseModel.fromJson(json.decode(response.data)));
  }

  void postFileApi(int id, Uint8List bytes,
      void Function(AboutUsResponseModel model) callback) async {
    var formData = FormData.fromMap({
      'id': id,
      'action': '6',
      'file': MultipartFile.fromBytes(bytes, filename: 'testName.jpg'),
    });

    var response = await Dio().post(
      'http://10.42.16.60/api/aboutUsPage.php',
      data: formData,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    print('AboutUsPageApi ${response.data}');
    callback(AboutUsResponseModel.fromJson(json.decode(response.data)));
  }
}
