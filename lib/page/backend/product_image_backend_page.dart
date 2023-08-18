import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/widget/bottom_bar_widget.dart';
import 'package:web_auto/widget/top_bar_widget.dart';

import '../../api/product_page_api.dart';
import '../../model/product_model.dart';
import '../../widget/edit_image_dialog.dart';
import '../../widget/top_bar_backed_widget.dart';

// 定义控制器类
class ProductImageBackedController extends GetxController {
  final productPageResponseModel = ProductResponseModel(code: 0, data: []).obs;
  final productIndex = 0.obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getApi();
  }

  void getApi() {
    ProductPageApi().postApi(ProductRequestModel(action: '0'), (model) {
      productPageResponseModel.value = model;
    });
  }

  void addData() {
    ProductPageApi().postApi(
        ProductRequestModel(
            action: '2',
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
            imageId: productPageResponseModel
                .value.data[productIndex.value].id), (model) {
      getApi();
    });
  }

  void deleteData(int index) {
    ProductPageApi().postApi(
        ProductRequestModel(
            action: '4',
            id: productPageResponseModel
                .value.data[productIndex.value].imageData[index].id), (model) {
      getApi();
    });
  }

  void dataUp(int index) {
    if (index > 0) {
      ProductPageApi().postApi(
          ProductRequestModel(
            action: '8',
            id1: productPageResponseModel
                .value.data[productIndex.value].imageData[index].id,
            id2: productPageResponseModel
                .value.data[productIndex.value].imageData[index - 1].id,
          ), (model) {
        getApi();
      });
    }
  }

  void dataDown(int index) {
    if (index <
        productPageResponseModel
                .value.data[productIndex.value].imageData.length -
            1) {
      ProductPageApi().postApi(
          ProductRequestModel(
            action: '8',
            id1: productPageResponseModel
                .value.data[productIndex.value].imageData[index].id,
            id2: productPageResponseModel
                .value.data[productIndex.value].imageData[index + 1].id,
          ), (model) {
        getApi();
      });
    }
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
        ProductPageApi().postFileApi(id, bytes, (model) {
          getApi();
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

class ProductImageBackendPage extends StatelessWidget {
  final ProductImageBackedController controller =
      Get.put(ProductImageBackedController());

  @override
  Widget build(BuildContext context) {
    // rest of your build method code
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
                    '產品輪播圖',
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
          controller.productPageResponseModel.value
              .data[controller.productIndex.value].imageData.length,
          (index) => DataRow(
            cells: [
              DataCell(Text('第$index個')),
              DataCell(Text(
                  'ID: ${controller.productPageResponseModel.value.data[controller.productIndex.value].imageData[index].id}')),
              DataCell(
                GestureDetector(
                  onTap: () {
                    controller.dataImageReplace(
                        index,
                        controller
                            .productPageResponseModel
                            .value
                            .data[controller.productIndex.value]
                            .imageData[index]
                            .id!,
                        controller
                            .productPageResponseModel
                            .value
                            .data[controller.productIndex.value]
                            .imageData[index]
                            .imageUrl);
                  },
                  child: Image.network(
                    controller
                        .productPageResponseModel
                        .value
                        .data[controller.productIndex.value]
                        .imageData[index]
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
