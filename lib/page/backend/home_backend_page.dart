import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/model/product_model.dart';

import '../../api/home_page_api.dart';
import '../../model/home_page_model.dart';
import '../../utils.dart';
import '../../widget/top_bar_backed_widget.dart';

// 定义控制器类
class HomePageBackedController extends GetxController {
  final homePageResponseModel = HomePageResponseModel(code: 0, data: []).obs;
  final List<ProductData> homePageResponsePageViewImages = [
    ProductData(
        category: '',
        name: '',
        images:
            'https://www.taiyimaterial.com.tw/taie/product/bimg/pro_20180426104042.jpg',
        description: '',
        videoLink: '',
        id: 0,
        type: '')
  ].obs;
  final List<ProductData> homePageResponseProductImages = [
    ProductData(
        category: '',
        name: '',
        images:
            'https://www.taiyimaterial.com.tw/taie/product/bimg/pro_20180426104042.jpg',
        description: '',
        videoLink: '',
        id: 0,
        type: '')
  ].obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getHomeApi();
  }

  void getHomeApi() {
    HomePageApi().postApi(HomePageRequestModel(action: '0'), (model) {
      homePageResponseModel.value = model;

      homePageResponsePageViewImages
        ..clear()
        ..addAll(homePageResponseModel.value.data
            .where((element) => element.type == 'pageViewImages'));

      homePageResponseProductImages
        ..clear()
        ..addAll(homePageResponseModel.value.data
            .where((element) => element.type == 'productImages'));
    });
  }

  void addPageData() {
    HomePageApi().postApi(
        HomePageRequestModel(
          action: '1',
          category: '類別',
          name: '測試',
          images: 'https://pic.616pic.com/ys_bnew_img/00/16/95/OjCm8gnt48.jpg',
          description: '測試',
          videoLink: '測試',
          type: 'pageViewImages',
        ), (model) {
      getHomeApi();
    });
    scrollToEnd();
  }

  void dataPageReplace(int index, Map<String, dynamic> map) {}

  void deletePageData(int id) {
    HomePageApi().postApi(
        HomePageRequestModel(
          action: '3',
          id: id,
        ), (model) {
      getHomeApi();
    });
  }

  void pageDataUp(int index) {
    if (index > 0) {
      HomePageApi().postApi(
          HomePageRequestModel(
            action: '4',
            id1: homePageResponsePageViewImages[index].id,
            id2: homePageResponsePageViewImages[index - 1].id,
          ), (model) {
        getHomeApi();
      });
    }
  }

  void pageDataDown(int index) {
    if (index < homePageResponsePageViewImages.length - 1) {
      HomePageApi().postApi(
          HomePageRequestModel(
            action: '4',
            id1: homePageResponsePageViewImages[index].id,
            id2: homePageResponsePageViewImages[index + 1].id,
          ), (model) {
        getHomeApi();
      });
    }
  }

  void addProductData() {
    HomePageApi().postApi(
        HomePageRequestModel(
          action: '1',
          category: '類別',
          name: '測試',
          images: 'https://pic.616pic.com/ys_bnew_img/00/16/95/OjCm8gnt48.jpg',
          description: '測試',
          videoLink: '測試',
          type: 'productImages',
        ), (model) {
      getHomeApi();
    });
    scrollToEnd();
  }

  void dataProductReplace(int index, Map<String, dynamic> map) {}

  void deleteProductData(int id) {
    HomePageApi().postApi(
        HomePageRequestModel(
          action: '3',
          id: id,
        ), (model) {
      getHomeApi();
    });
  }

  void productDataUp(int index) {
    if (index > 0) {
      HomePageApi().postApi(
          HomePageRequestModel(
            action: '4',
            id1: homePageResponseProductImages[index].id,
            id2: homePageResponseProductImages[index - 1].id,
          ), (model) {
        getHomeApi();
      });
    }
  }

  void productDataDown(int index) {
    if (index < homePageResponseProductImages.length - 1) {
      HomePageApi().postApi(
          HomePageRequestModel(
            action: '4',
            id1: homePageResponseProductImages[index].id,
            id2: homePageResponseProductImages[index + 1].id,
          ), (model) {
        getHomeApi();
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
          controller.homePageResponsePageViewImages.length,
          (index) => DataRow(
            cells: [
              DataCell(Text('第$index個')),
              DataCell(Text(
                  'ID: ${controller.homePageResponsePageViewImages[index].id}')),
              DataCell(
                CachedNetworkImage(
                  imageUrl:
                      controller.homePageResponsePageViewImages[index].images,
                  width: 120,
                  height: 120,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Container(),
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
                            controller.deletePageData(controller
                                .homePageResponsePageViewImages[index].id);
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
          controller.homePageResponseProductImages.length,
          (index) => DataRow(
            cells: [
              DataCell(Text('第$index個')),
              DataCell(Text(
                  'ID: ${controller.homePageResponseProductImages[index].id}')),
              DataCell(
                CachedNetworkImage(
                  imageUrl:
                      controller.homePageResponseProductImages[index].images,
                  width: 120,
                  height: 120,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Container(),
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
                            controller.deleteProductData(controller
                                .homePageResponseProductImages[index].id);
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
