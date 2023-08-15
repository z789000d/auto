import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:web_auto/model/home_page_model.dart';
import 'package:web_auto/model/news_page_model.dart';
import 'package:web_auto/model/product_model.dart';

class ProductPageApi {
  void postApi(ProductRequestModel productRequestModel,
      void Function(ProductResponseModel model) callback) async {
    var response = await Dio().post(
      'http://10.42.16.60/api/productPage.php',
      data: productRequestModel.toJson(),
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    print('postApi ${response.data}');
    callback(ProductResponseModel.fromJson(json.decode(response.data)));
  }
}
