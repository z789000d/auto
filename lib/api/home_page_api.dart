import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:web_auto/model/bus_model.dart';
import 'package:web_auto/model/home_page_model.dart';

class HomePageApi {
  void getApi(void Function(HomePageResponseModel model) callback) async {
    var response = await Dio().get('http://10.42.16.60/api/homePage.php');
    print('aaaaa ccccc ${response.data}');
    callback(HomePageResponseModel.fromJson(response.data));
  }

  void postApi(HomePageRequestModel homePageRequestModel,
      void Function(HomePageResponseModel model) callback) async {
    var response = await Dio().post(
      'http://10.42.16.60/api/homePage.php',
      data: homePageRequestModel.toJson(),
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    print('HomePageApi ${response.data}');
    callback(HomePageResponseModel.fromJson(json.decode(response.data)));
  }
}
