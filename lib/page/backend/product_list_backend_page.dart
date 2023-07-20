import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/widget/bottom_bar_widget.dart';
import 'package:web_auto/widget/top_bar_widget.dart';

import '../../widget/top_bar_backed_widget.dart';

// 定义控制器类
class ProductListBackendController extends GetxController {
  // 假设有一个包含数据的 List
  RxList<Map<String, dynamic>> data = <Map<String, dynamic>>[].obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    // 初始化数据
    for (int i = 0; i < 10; i++) {
      data.add({
        'id': i,
        'category': '類別$i',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
        'name': '產品$i',
        'function': 'Function $i',
        'description': '描述$i',
        'videoLink': '連結$i'
      });
    }
  }

  void addData() {
    data.add({
      'id': data.length,
      'category': '類別${data.length}',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
      'name': '產品${data.length}',
      'function': 'Function ${data.length}',
      'description': '描述${data.length}',
      'videoLink': '連結${data.length}'
    });
    scrollToEnd();
  }

  void deleteData(int index) {
    data.removeAt(index);
  }

  void scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    });
  }
}

class ProductListBackendPage extends StatelessWidget {
  final ProductListBackendController controller =
      Get.put(ProductListBackendController());

  @override
  Widget build(BuildContext context) {
    // 使用GetX来获取控制器实例

    return Scaffold(
      body: SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBarBacked(),
              Container(margin: EdgeInsets.all(10), child: table()),
              Container(
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // 设置边框颜色
                    width: 1, // 设置边框宽度
                  ),
                ),
                child: GestureDetector(
                    onTap: () {
                      controller.addData();
                    },
                    child: Text('新增')),
              )
            ],
          )),
    );
  }

  Widget table() {
    return Obx(
      () => DataTable(
        dividerThickness: 1,
        // 设置分隔线的厚度
        dataRowMinHeight: 100,
        dataRowMaxHeight: 150,
        columns: [
          DataColumn(
              label: Expanded(
                  child: Container(
                      alignment: Alignment.center, child: Text('id')))),
          DataColumn(
              label: Expanded(
                  child: Container(
                      alignment: Alignment.center, child: Text('類別')))),
          DataColumn(
              label: Expanded(
                  child: Container(
                      alignment: Alignment.center, child: Text('圖片')))),
          DataColumn(
              label: Expanded(
                  child: Container(
                      alignment: Alignment.center, child: Text('產品名稱')))),
          DataColumn(
              label: Expanded(
                  child: Container(
                      alignment: Alignment.center, child: Text('描述')))),
          DataColumn(
              label: Expanded(
                  child: Container(
                      alignment: Alignment.center, child: Text('影片連結')))),
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
              DataCell(Text('類別: ${controller.data[index]['category']}')),
              DataCell(
                Image.network(
                  controller.data[index]['image'],
                  width: 120,
                  height: 120,
                ),
              ),
              DataCell(Text('name: ${controller.data[index]['name']}')),
              DataCell(Text(
                  'description: ${controller.data[index]['description']}')),
              DataCell(
                  Text('videoLink: ${controller.data[index]['videoLink']}')),
              DataCell(Row(
                children: [
                  Container(child: Text('修改')),
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: GestureDetector(
                          onTap: () {
                            controller.deleteData(index);
                          },
                          child: Text('刪除'))),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
