import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/model/about_us_model.dart';
import 'package:web_auto/widget/bottom_bar_widget.dart';
import 'package:web_auto/widget/top_bar_widget.dart';

import '../../api/about_us_page_api.dart';
import '../../widget/edit_image_dialog.dart';
import '../../widget/top_bar_backed_widget.dart';

// 定义控制器类
class AboutUsBackendController extends GetxController {
  Rx<AboutUsResponseModel> aboutUsModel = AboutUsResponseModel(
          code: 0, aboutUsData: AboutUsData(imageData: [], text: ''))
      .obs;

  final companyContentController = TextEditingController().obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();

    getApi();
  }

  void getApi() {
    AboutUsPageApi().postApi(AboutUsRequestModel(action: 0), (model) {
      aboutUsModel.value = model;
      companyContentController.value.text = model.aboutUsData.text!;
    });
  }

  void chageText() {
    AboutUsPageApi().postApi(
        AboutUsRequestModel(
            action: 2,
            text: companyContentController.value.text,
            id: 1), (model) {
      getApi();
    });
  }

  void dataImageReplace(int index, int id, String? url) {
    Get.dialog(
      EditImageDialog(url: url),
      barrierDismissible: false,
    ).then((value) {
      if (value == 'Cancel') {
        print('User canceled.');
      } else {
        Uint8List bytes = value;
        AboutUsPageApi().postFileApi(id, bytes, (model) {
          getApi();
        });
      }
    });
  }

  void addData() {
    AboutUsPageApi().postApi(
        AboutUsRequestModel(
            action: 1,
            imageUrl:
                'https://pic.616pic.com/ys_bnew_img/00/16/95/OjCm8gnt48.jpg'),
        (model) {
      getApi();
    });
    scrollToEnd();
  }

  void deleteData(int id) {
    AboutUsPageApi().postApi(AboutUsRequestModel(action: 5, imageId: id),
        (model) {
      getApi();
    });
  }

  void dataUp(int index) {
    if (index > 0) {
      AboutUsPageApi().postApi(
          AboutUsRequestModel(
            action: 4,
            id1: aboutUsModel.value.aboutUsData.imageData[index].id,
            id2: aboutUsModel.value.aboutUsData.imageData[index - 1].id,
          ), (model) {
        getApi();
      });
    }
  }

  void dataDown(int index) {
    if (index < aboutUsModel.value.aboutUsData.imageData.length - 1) {
      AboutUsPageApi().postApi(
          AboutUsRequestModel(
            action: 4,
            id1: aboutUsModel.value.aboutUsData.imageData[index].id,
            id2: aboutUsModel.value.aboutUsData.imageData[index + 1].id,
          ), (model) {
        getApi();
      });
    }
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

class AboutUsBackendPage extends StatelessWidget {
  final AboutUsBackendController controller =
      Get.put(AboutUsBackendController());

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
                    '關於我們',
                    style: TextStyle(fontSize: 20),
                  )),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    width: 80,
                    child: Text(
                      '介紹:',
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: TextField(
                        maxLines: 10,
                        controller: controller.companyContentController.value,
                        style: TextStyle(fontSize: 12.0),
                        decoration: InputDecoration(
                          hintText: '輸入介紹',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(width: 1.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // 设置边框颜色
                        width: 1, // 设置边框宽度
                      ),
                    ),
                    child: GestureDetector(
                        onTap: () {
                          controller.chageText();
                        },
                        child: Text('修改')),
                  ),
                ],
              ),
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
        dividerThickness: 1,
        // 设置分隔线的厚度
        dataRowMinHeight: 100,
        dataRowMaxHeight: 150,
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
                      alignment: Alignment.center, child: Text('圖片')))),
          DataColumn(
              label: Expanded(
                  child: Container(
                      alignment: Alignment.center, child: Text('功能')))),
        ],
        rows: List<DataRow>.generate(
          controller.aboutUsModel.value.aboutUsData.imageData.length,
          (index) => DataRow(
            cells: [
              DataCell(Text('第$index個')),
              DataCell(Text(
                  'ID: ${controller.aboutUsModel.value.aboutUsData.imageData[index].id}')),
              DataCell(
                GestureDetector(
                  onTap: () {
                    controller.dataImageReplace(
                        index,
                        controller.aboutUsModel.value.aboutUsData
                            .imageData[index].id!,
                        controller.aboutUsModel.value.aboutUsData
                            .imageData[index].imageUrl);
                  },
                  child: Image.network(
                    controller.aboutUsModel.value.aboutUsData.imageData[index]
                        .imageUrl!,
                    width: 120,
                    height: 120,
                  ),
                ),
              ),
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
                            controller.deleteData(controller.aboutUsModel.value
                                .aboutUsData.imageData[index].id!);
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
