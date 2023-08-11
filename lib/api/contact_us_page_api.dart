import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:web_auto/model/contact_us_model.dart';
import 'package:web_auto/model/home_page_model.dart';
import 'package:web_auto/model/news_page_model.dart';

class ContactUsPageApi {
  void postApi(ContactUsRequestModel contactUsRequestModel,
      void Function(ContactUsResponseModel model) callback) async {
    var response = await Dio().post(
      'http://10.42.16.60/api/contactUsPage.php',
      data: contactUsRequestModel.toJson(),
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    print('postApi ${response.data}');
    callback(ContactUsResponseModel.fromJson(json.decode(response.data)));
  }
}
