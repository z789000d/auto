import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/model/product_model.dart';

import '../../model/home_page_model.dart';
import '../../utils.dart';
import '../../widget/top_bar_backed_widget.dart';

// 定义控制器类
class HomePageBackedController extends GetxController {
  final homePageModel =
      HomePageModel(pageViewImages: [], productImages: []).obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    // 初始化数据

    for (int i = 0; i < 10; i++) {
      homePageModel.value.productImages.add(ProductModel(
          id: '$i',
          category: '類別$i',
          name: '名稱$i',
          images: Utils.testImage,
          description: '描述$i',
          videoLink: '影片$i'));

      homePageModel.value.pageViewImages.add(ProductModel(
          id: '$i',
          category: '類別$i',
          name: '名稱$i',
          images: Utils.testImage,
          description: '描述$i',
          videoLink: '影片$i'));
    }
  }

  void addPageData() {
    HomePageModel homePageModelOriginal = homePageModel.value.copyWith();
    homePageModelOriginal.pageViewImages.add(ProductModel(
        id: '${homePageModel.value.productImages.length}',
        category: '類別${homePageModel.value.productImages.length}',
        name: '名稱${homePageModel.value.productImages.length}',
        images: Utils.testImage,
        description: '描述${homePageModel.value.productImages.length}',
        videoLink: '影片${homePageModel.value.productImages.length}'));

    homePageModel.value = homePageModelOriginal;

    scrollToEnd();
  }

  void dataPageReplace(int index, Map<String, dynamic> map) {}

  void deletePageData(int index) {
    HomePageModel homePageModelOriginal = homePageModel.value.copyWith();
    homePageModelOriginal.pageViewImages.removeAt(index);
    homePageModel.value = homePageModelOriginal;
  }

  void pageDataUp(int index) {
    if (index > 0) {
      HomePageModel homePageModelOriginal = homePageModel.value.copyWith();
      homePageModelOriginal.pageViewImages.insert(
          index - 1, homePageModelOriginal.pageViewImages.removeAt(index));
      homePageModel.value = homePageModelOriginal;
    }
  }

  void pageDataDown(int index) {
    if (index < homePageModel.value.pageViewImages.length - 1) {
      HomePageModel homePageModelOriginal = homePageModel.value.copyWith();
      homePageModelOriginal.pageViewImages.insert(
          index + 1, homePageModelOriginal.pageViewImages.removeAt(index));
      homePageModel.value = homePageModelOriginal;
    }
  }

  void addProductData() {
    HomePageModel homePageModelOriginal = homePageModel.value.copyWith();
    homePageModelOriginal.productImages.add(ProductModel(
        id: '${homePageModel.value.productImages.length}',
        category: '類別${homePageModel.value.productImages.length}',
        name: '名稱${homePageModel.value.productImages.length}',
        images: Utils.testImage,
        description: '描述${homePageModel.value.productImages.length}',
        videoLink: '影片${homePageModel.value.productImages.length}'));
    homePageModel.value = homePageModelOriginal;

    scrollToEnd();
  }

  void dataProductReplace(int index, Map<String, dynamic> map) {}

  void deleteProductData(int index) {
    HomePageModel homePageModelOriginal = homePageModel.value.copyWith();
    homePageModelOriginal.productImages.removeAt(index);
    homePageModel.value = homePageModelOriginal;
  }

  void productDataUp(int index) {
    if (index > 0) {
      HomePageModel homePageModelOriginal = homePageModel.value.copyWith();
      homePageModelOriginal.productImages.insert(
          index - 1, homePageModelOriginal.productImages.removeAt(index));
      homePageModel.value = homePageModelOriginal;
    }
  }

  void productDataDown(int index) {
    if (index < homePageModel.value.productImages.length - 1) {
      HomePageModel homePageModelOriginal = homePageModel.value.copyWith();
      homePageModelOriginal.productImages.insert(
          index + 1, homePageModelOriginal.productImages.removeAt(index));
      homePageModel.value = homePageModelOriginal;
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

class HomeBackendPage extends StatelessWidget {
  final HomePageBackedController controller =
      Get.put(HomePageBackedController());

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
              SingleChildScrollView(
                controller: ScrollController(),
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: Get.width < 1400 ? 1400 : Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                '首頁輪播圖',
                                style: TextStyle(fontSize: 20),
                              )),
                          Container(
                              margin: EdgeInsets.all(10), child: tablePage()),
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
                                  controller.addPageData();
                                },
                                child: Text('新增')),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                '首頁產品圖',
                                style: TextStyle(fontSize: 20),
                              )),
                          Container(
                              margin: EdgeInsets.all(10),
                              child: tableProduct()),
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
                                  controller.addProductData();
                                },
                                child: Text('新增')),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget tablePage() {
    return Obx(
      () => DataTable(
        dividerThickness: 1,
        // 设置分隔线的厚度,
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
          controller.homePageModel.value.pageViewImages.length,
          (index) => DataRow(
            cells: [
              DataCell(Text('第$index個')),
              DataCell(Text(
                  'ID: ${controller.homePageModel.value.pageViewImages[index].id}')),
              DataCell(
                Image.network(
                  controller
                      .homePageModel.value.pageViewImages[index].images[0],
                  width: 120,
                  height: 120,
                ),
              ),
              DataCell(Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: GestureDetector(
                        onTap: () {
                          controller.pageDataUp(index);
                        },
                        child: Text('上升')),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: GestureDetector(
                        onTap: () {
                          controller.pageDataDown(index);
                        },
                        child: Text('下降')),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20), child: Text('修改')),
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: GestureDetector(
                          onTap: () {
                            controller.deletePageData(index);
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

  Widget tableProduct() {
    return Obx(
      () => DataTable(
        dividerThickness: 1,
        // 设置分隔线的厚度,
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
          controller.homePageModel.value.productImages.length,
          (index) => DataRow(
            cells: [
              DataCell(Text('第$index個')),
              DataCell(Text(
                  'ID: ${controller.homePageModel.value.productImages[index].id}')),
              DataCell(
                Image.network(
                  controller.homePageModel.value.productImages[index].images[0],
                  width: 120,
                  height: 120,
                ),
              ),
              DataCell(Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: GestureDetector(
                        onTap: () {
                          controller.productDataUp(index);
                        },
                        child: Text('上升')),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: GestureDetector(
                        onTap: () {
                          controller.productDataDown(index);
                        },
                        child: Text('下降')),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20), child: Text('修改')),
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: GestureDetector(
                          onTap: () {
                            controller.deleteProductData(index);
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
