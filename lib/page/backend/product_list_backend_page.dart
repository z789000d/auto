import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/page/backend/product_image_backend_page.dart';
import 'package:web_auto/widget/bottom_bar_widget.dart';
import 'package:web_auto/widget/top_bar_widget.dart';

import '../../api/product_page_api.dart';
import '../../model/product_model.dart';
import '../../widget/edit_text_dialog.dart';
import '../../widget/top_bar_backed_widget.dart';

// 定义控制器类
class ProductListBackendController extends GetxController {
  final productPageResponseModel = ProductResponseModel(code: 0, data: []).obs;
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

  void replaceCategory(int index) {
    Get.dialog(
      EditTextDialog(text: productPageResponseModel.value.data[index].category),
      barrierDismissible: false,
    ).then((value) {
      if (value == 'Cancel') {
        print('User canceled.');
      } else {
        ProductPageApi().postApi(
            ProductRequestModel(
                action: '5',
                id: productPageResponseModel.value.data[index].id,
                category: value,
                name: productPageResponseModel.value.data[index].name,
                description:
                    productPageResponseModel.value.data[index].description,
                videoLink: productPageResponseModel
                    .value.data[index].videoLink), (model) {
          getApi();
        });
      }
    });
  }

  void replaceName(int index) {
    Get.dialog(
      EditTextDialog(text: productPageResponseModel.value.data[index].name),
      barrierDismissible: false,
    ).then((value) {
      if (value == 'Cancel') {
        print('User canceled.');
      } else {
        print('aaaaaa ${value}');
        ProductPageApi().postApi(
            ProductRequestModel(
                action: '5',
                id: productPageResponseModel.value.data[index].id,
                category: productPageResponseModel.value.data[index].category,
                name: value,
                description:
                    productPageResponseModel.value.data[index].description,
                videoLink: productPageResponseModel
                    .value.data[index].videoLink), (model) {
          getApi();
        });
      }
    });
  }

  void replaceDescription(int index) {
    Get.dialog(
      EditTextDialog(
          text: productPageResponseModel.value.data[index].description),
      barrierDismissible: false,
    ).then((value) {
      if (value == 'Cancel') {
        print('User canceled.');
      } else {
        ProductPageApi().postApi(
            ProductRequestModel(
                action: '5',
                id: productPageResponseModel.value.data[index].id,
                category: productPageResponseModel.value.data[index].category,
                name: productPageResponseModel.value.data[index].name,
                description: value,
                videoLink: productPageResponseModel
                    .value.data[index].videoLink), (model) {
          getApi();
        });
      }
    });
  }

  void replaceVideoLink(int index) {
    Get.dialog(
      EditTextDialog(
          text: productPageResponseModel.value.data[index].videoLink),
      barrierDismissible: false,
    ).then((value) {
      if (value == 'Cancel') {
        print('User canceled.');
      } else {
        ProductPageApi().postApi(
            ProductRequestModel(
                action: '5',
                id: productPageResponseModel.value.data[index].id,
                category: productPageResponseModel.value.data[index].category,
                name: productPageResponseModel.value.data[index].name,
                description:
                    productPageResponseModel.value.data[index].description,
                videoLink: value), (model) {
          getApi();
        });
      }
    });
  }

  void addData() {
    ProductPageApi().postApi(
        ProductRequestModel(
            action: '1',
            category: '類別${productPageResponseModel.value.data.length}',
            name: '產品${productPageResponseModel.value.data.length}',
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
            description: '描述${productPageResponseModel.value.data.length}',
            videoLink: '連結${productPageResponseModel.value.data.length}'),
        (model) {
      getApi();
    });

    scrollToEnd();
  }

  void deleteData(int index) {
    ProductPageApi().postApi(
        ProductRequestModel(
            action: '3',
            id: productPageResponseModel.value.data[index].id), (model) {
      getApi();
    });
  }

  void dataUp(int index) {
    if (index > 0) {
      ProductPageApi().postApi(
          ProductRequestModel(
            action: '7',
            id1: productPageResponseModel.value.data[index].id,
            id2: productPageResponseModel.value.data[index - 1].id,
          ), (model) {
        getApi();
      });
    }
  }

  void dataDown(int index) {
    if (index < productPageResponseModel.value.data.length - 1) {
      ProductPageApi().postApi(
          ProductRequestModel(
            action: '7',
            id1: productPageResponseModel.value.data[index].id,
            id2: productPageResponseModel.value.data[index + 1].id,
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
              Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    '產品清單',
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
                      alignment: Alignment.center, child: Text('排序')))),
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
          controller.productPageResponseModel.value.data.length,
          (index) => DataRow(
            cells: [
              DataCell(Text('第$index個')),
              DataCell(Text(
                  '${controller.productPageResponseModel.value.data[index].id}')),
              DataCell(GestureDetector(
                onTap: () {
                  controller.replaceCategory(index);
                },
                child: Text(
                    '${controller.productPageResponseModel.value.data[index].category}'),
              )),
              DataCell(
                GestureDetector(
                  onTap: () {
                    Get.delete<ProductImageBackedController>();

                    final ProductImageBackedController
                        productImageBackedController =
                        Get.put(ProductImageBackedController());

                    productImageBackedController.productPageResponseModel
                        .value = controller.productPageResponseModel.value;

                    productImageBackedController.productIndex.value = index;
                    Get.to(ProductImageBackendPage());
                  },
                  child: Image.network(
                    controller.productPageResponseModel.value.data[index]
                        .imageData[0].imageUrl!,
                    width: 120,
                    height: 120,
                  ),
                ),
              ),
              DataCell(GestureDetector(
                onTap: () {
                  controller.replaceName(index);
                },
                child: Text(
                    '${controller.productPageResponseModel.value.data[index].name}'),
              )),
              DataCell(GestureDetector(
                onTap: () {
                  controller.replaceDescription(index);
                },
                child: Text(
                    '${controller.productPageResponseModel.value.data[index].description}'),
              )),
              DataCell(GestureDetector(
                onTap: () {
                  controller.replaceVideoLink(index);
                },
                child: Text(
                    '${controller.productPageResponseModel.value.data[index].videoLink}'),
              )),
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
