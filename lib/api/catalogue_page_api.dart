import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:dio/dio.dart';

import '../model/catalogue_model.dart';


class CataloguePageApi {
  void postApi(CatalogueRequestModel catalogueRequestModel,
      void Function(CatalogueResponseModel model) callback) async {
    var response = await Dio().post(
      'http://10.42.16.60/api/cataloguePage.php',
      data: catalogueRequestModel.toJson(),
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    print('postApi ${response.data}');
    callback(CatalogueResponseModel.fromJson(json.decode(response.data)));
  }

  void postFileApi(int id, Uint8List bytes,
      void Function(CatalogueResponseModel model) callback) async {
    var formData = FormData.fromMap({
      'id': id,
      'action': '9',
      'file': MultipartFile.fromBytes(bytes, filename: 'testName.jpg'),
    });

    var response = await Dio().post(
      'http://10.42.16.60/api/cataloguePage.php',
      data: formData,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    print('CataloguePageApi ${response.data}');
    callback(CatalogueResponseModel.fromJson(json.decode(response.data)));
  }
}
