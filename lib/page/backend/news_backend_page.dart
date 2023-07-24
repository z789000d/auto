import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/widget/bottom_bar_widget.dart';
import 'package:web_auto/widget/top_bar_widget.dart';

import '../../widget/top_bar_backed_widget.dart';

// 定义控制器类
class NewsBackedController extends GetxController {
  // 假设有一个包含数据的 List
  RxList<Map<String, dynamic>> data = <Map<String, dynamic>>[].obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    // 初始化数据
    for (int i = 0; i < 10; i++) {
      data.add({'id': i, 'newsText': '最新消息$i', 'function': 'Function $i'});
    }
  }

  void addData() {
    data.add({
      'id': data.length,
      'newsText': '最新消息${data.length}',
      'function': 'Function ${data.length}'
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

class NewsBackendPage extends StatelessWidget {
  final NewsBackedController controller = Get.put(NewsBackedController());

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
              Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    '最新消息',
                    style: TextStyle(fontSize: 20),
                  )),
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
              ),
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
                      alignment: Alignment.center, child: Text('排序')))),
          DataColumn(
              label: Expanded(
                  child: Container(
                      alignment: Alignment.center, child: Text('id')))),
          DataColumn(
              label: Expanded(
                  child: Container(
                      alignment: Alignment.center, child: Text('最新消息文字')))),
          DataColumn(
              label: Expanded(
                  child: Container(
                      alignment: Alignment.center, child: Text('功能')))),
        ],
        rows: List<DataRow>.generate(
          controller.data.length,
          (index) => DataRow(
            cells: [
              DataCell(Text('第$index個')),
              DataCell(Text('ID: ${controller.data[index]['id']}')),
              DataCell(Text('newsText: ${controller.data[index]['newsText']}')),
              DataCell(Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: GestureDetector(
                        onTap: () {
                          if (index > 0) {
                            controller.data.insert(
                                index - 1, controller.data.removeAt(index));
                          }
                        },
                        child: Text('上升')),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: GestureDetector(
                        onTap: () {
                          if (index < controller.data.length - 1) {
                            controller.data.insert(
                                index + 1, controller.data.removeAt(index));
                          }
                        },
                        child: Text('下降')),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20), child: Text('修改')),
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
