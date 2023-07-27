import 'dart:async';
import 'package:get/get.dart';
import 'package:web_auto/model/bus_model.dart';

class BusApi {
  void getApi(void Function(BusModel model) callback) async {
    var response =
        await GetConnect().get('http://10.42.110.3:8888/RealTimeByFrequency');
    callback(BusModel.fromJson(response.body));
  }
}
