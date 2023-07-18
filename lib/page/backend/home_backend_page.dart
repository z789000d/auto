import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/widget/bottom_bar_widget.dart';
import 'package:web_auto/widget/top_bar_widget.dart';

// 定义控制器类
class HomePageBackedController extends GetxController {
  // 假设有一个包含数据的 List
  RxList<Map<String, dynamic>> data = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // 初始化数据
    for (int i = 0; i < 10; i++) {
      data.add({'id': i, 'image': 'url$i', 'function': 'Function $i'});
    }
  }
}

class HomeBackendPage extends StatelessWidget {
  final HomePageBackedController controller =
      Get.put(HomePageBackedController());

  @override
  Widget build(BuildContext context) {
    // 使用GetX来获取控制器实例

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          table(),
          Container(margin: EdgeInsets.all(25), child: Text('新增')),
        ],
      )),
    );
  }

  Widget table() {
    return Obx(
      () => DataTable(
        dividerThickness: 1, // 设置分隔线的厚度
        columns: [
          DataColumn(
              label: Expanded(
                  child: Container(
                      alignment: Alignment.center, child: Text('id')))),
          DataColumn(
              label: Expanded(
                  child: Container(
                      alignment: Alignment.center, child: Text('圖片')))),
          DataColumn(
              label: Expanded(
                  child: Container(
                      alignment: Alignment.center, child: Text('功能')))),
        ],
        rows: List<DataRow>.generate(
          controller.data.length,
          (index) => DataRow(
            cells: [
              DataCell(Text('ID: ${controller.data[index]['id']}')),
              DataCell(Text('Image: ${controller.data[index]['image']}')),
              DataCell(Row(
                children: [
                  Container(child: Text('修改')),
                  Container(
                      margin: EdgeInsets.only(left: 20), child: Text('刪除')),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
