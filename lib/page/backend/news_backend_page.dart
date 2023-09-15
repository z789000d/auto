import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/model/news_page_model.dart';
import 'package:web_auto/widget/bottom_bar_widget.dart';
import 'package:web_auto/widget/top_bar_widget.dart';

import '../../api/news_page_api.dart';
import '../../widget/edit_text_dialog.dart';
import '../../widget/top_bar_backed_widget.dart';

// 定义控制器类
class NewsBackedController extends GetxController {
  // 假设有一个包含数据的 List
  Rx<NewsPageResponseModel> newsModel = NewsPageResponseModel(
    data: [NewsData(id: 0, news: '', date: '')],
    code: 0,
  ).obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    // 初始化数据
    getNewsApi();
  }

  void getNewsApi() {
    newsModel.value.data.clear();
    NewsPageApi().postApi(NewsPageRequestModel(action: '0'), (model) {
      newsModel.value = model;
      print('aaaa ${newsModel.value.data.length}');
    });
  }

  void addData() {
    NewsPageApi().postApi(
        NewsPageRequestModel(
            action: '1', news: '消息${newsModel.value.data.length}'), (model) {
      getNewsApi();
    });
    scrollToEnd();
  }

  void deleteData(int id) {
    NewsPageApi().postApi(NewsPageRequestModel(action: '3', id: id), (model) {
      getNewsApi();
    });
  }

  void dataUp(int index) {
    if (index > 0) {
      NewsPageApi().postApi(
          NewsPageRequestModel(
            action: '4',
            id1: newsModel.value.data[index].id,
            id2: newsModel.value.data[index - 1].id,
          ), (model) {
        getNewsApi();
      });
    }
  }

  void dataDown(int index) {
    if (index < newsModel.value.data.length - 1) {
      NewsPageApi().postApi(
          NewsPageRequestModel(
            action: '4',
            id1: newsModel.value.data[index].id,
            id2: newsModel.value.data[index + 1].id,
          ), (model) {
        getNewsApi();
      });
    }
  }

  void replaceNews(int index, int id) {
    final EditTextDialogController controller =
        Get.put(EditTextDialogController());
    controller.textEditingController.text = newsModel.value.data[index].news;
    Get.dialog(
      EditTextDialog(),
      barrierDismissible: false,
    ).then((value) {
      if (value == 'Cancel') {
        print('User canceled.');
      } else {
        NewsPageApi().postApi(
            NewsPageRequestModel(action: '2', id: id, news: value), (model) {
          getNewsApi();
        });
      }
    });
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
                      alignment: Alignment.center, child: Text('日期')))),
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
          controller.newsModel.value.data.length,
          (index) => DataRow(
            cells: [
              DataCell(Text('第$index個')),
              DataCell(Text('${controller.newsModel.value.data[index].id}')),
              DataCell(Text('${controller.newsModel.value.data[index].date}')),
              DataCell(GestureDetector(
                  onTap: () {
                    controller.replaceNews(
                        index, controller.newsModel.value.data[index].id);
                  },
                  child:
                      Text('${controller.newsModel.value.data[index].news}'))),
              DataCell(Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: GestureDetector(
                        onTap: () {
                          controller.dataUp(index);
                        },
                        child: Text('上升')),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: GestureDetector(
                        onTap: () {
                          controller.dataDown(index);
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
