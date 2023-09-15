import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/model/product_model.dart';
import 'package:web_auto/widget/edit_text_dialog.dart';

import '../../api/home_page_api.dart';
import '../../model/home_page_model.dart';
import '../../utils.dart';
import '../../widget/edit_image_dialog.dart';
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
          category: '全部',
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

  void dataPageNameReplace(int index, int id) {
    final EditTextDialogController controller =
        Get.put(EditTextDialogController());
    controller.textEditingController.text =
        homePageResponsePageViewImages[index].name;
    Get.dialog(
      EditTextDialog(),
      barrierDismissible: false,
    ).then((value) {
      if (value == 'Cancel') {
        print('User canceled.');
      } else {
        HomePageApi().postApi(
            HomePageRequestModel(
                action: '2',
                id: id,
                category: homePageResponsePageViewImages[index].category,
                name: value,
                images: homePageResponsePageViewImages[index].images,
                description: homePageResponsePageViewImages[index].description,
                videoLink: homePageResponsePageViewImages[index].videoLink,
                type: homePageResponsePageViewImages[index].type), (model) {
          getHomeApi();
        });
      }
    });
  }

  void dataPageDescriptionReplace(int index, int id) {
    final EditTextDialogController controller =
        Get.put(EditTextDialogController());
    controller.textEditingController.text =
        homePageResponsePageViewImages[index].description;
    Get.dialog(
      EditTextDialog(),
      barrierDismissible: false,
    ).then((value) {
      if (value == 'Cancel') {
        print('User canceled.');
      } else {
        HomePageApi().postApi(
            HomePageRequestModel(
                action: '2',
                id: id,
                category: homePageResponsePageViewImages[index].category,
                name: homePageResponsePageViewImages[index].name,
                images: homePageResponsePageViewImages[index].images,
                description: value,
                videoLink: homePageResponsePageViewImages[index].videoLink,
                type: homePageResponsePageViewImages[index].type), (model) {
          getHomeApi();
        });
      }
    });
  }

  void dataPageVideoLinkReplace(int index, int id) {
    final EditTextDialogController controller =
        Get.put(EditTextDialogController());
    controller.textEditingController.text =
        homePageResponsePageViewImages[index].videoLink;
    Get.dialog(
      EditTextDialog(),
      barrierDismissible: false,
    ).then((value) {
      if (value == 'Cancel') {
        print('User canceled.');
      } else {
        HomePageApi().postApi(
            HomePageRequestModel(
                action: '2',
                id: id,
                category: homePageResponsePageViewImages[index].category,
                name: homePageResponsePageViewImages[index].name,
                images: homePageResponsePageViewImages[index].images,
                description: homePageResponsePageViewImages[index].description,
                videoLink: value,
                type: homePageResponsePageViewImages[index].type), (model) {
          getHomeApi();
        });
      }
    });
  }

  void dataPageImageReplace(int index, int id, String? url) {
    Get.dialog(
      EditImageDialog(url: url),
      barrierDismissible: false,
    ).then((value) {
      if (value == 'Cancel') {
        print('User canceled.');
      } else {
        Uint8List bytes = value;
        HomePageApi().postFileApi(id, bytes, (model) {
          getHomeApi();
        });
      }
    });
  }

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

  void dataProductNameReplace(int index, int id) {
    final EditTextDialogController controller =
        Get.put(EditTextDialogController());
    controller.textEditingController.text = homePageResponseProductImages[index].name;
    Get.dialog(
      EditTextDialog(),
      barrierDismissible: false,
    ).then((value) {
      if (value == 'Cancel') {
        print('User canceled.');
      } else {
        HomePageApi().postApi(
            HomePageRequestModel(
                action: '2',
                id: id,
                category: homePageResponseProductImages[index].category,
                name: value,
                images: homePageResponseProductImages[index].images,
                description: homePageResponseProductImages[index].description,
                videoLink: homePageResponseProductImages[index].videoLink,
                type: homePageResponseProductImages[index].type), (model) {
          getHomeApi();
        });
      }
    });
  }

  void dataProductImageReplace(int index, int id, String? url) {
    Get.dialog(
      EditImageDialog(url: url),
      barrierDismissible: false,
    ).then((value) {
      if (value == 'Cancel') {
        print('User canceled.');
      } else {
        Uint8List bytes = value;
        HomePageApi().postFileApi(id, bytes, (model) {
          getHomeApi();
        });
      }
    });
  }

  void dataProductDescriptionReplace(int index, int id) {
    final EditTextDialogController controller =
        Get.put(EditTextDialogController());
    controller.textEditingController.text =
        homePageResponseProductImages[index].description;
    Get.dialog(
      EditTextDialog(),
      barrierDismissible: false,
    ).then((value) {
      if (value == 'Cancel') {
        print('User canceled.');
      } else {
        HomePageApi().postApi(
            HomePageRequestModel(
                action: '2',
                id: id,
                category: homePageResponseProductImages[index].category,
                name: homePageResponseProductImages[index].name,
                images: homePageResponseProductImages[index].images,
                description: value,
                videoLink: homePageResponseProductImages[index].videoLink,
                type: homePageResponseProductImages[index].type), (model) {
          getHomeApi();
        });
      }
    });
  }

  void dataProductVideoLinkReplace(int index, int id) {
    final EditTextDialogController controller =
        Get.put(EditTextDialogController());
    controller.textEditingController.text =
        homePageResponseProductImages[index].videoLink;
    Get.dialog(
      EditTextDialog(),
      barrierDismissible: false,
    ).then((value) {
      if (value == 'Cancel') {
        print('User canceled.');
      } else {
        HomePageApi().postApi(
            HomePageRequestModel(
                action: '2',
                id: id,
                category: homePageResponseProductImages[index].category,
                name: homePageResponseProductImages[index].name,
                images: homePageResponseProductImages[index].images,
                description: homePageResponseProductImages[index].description,
                videoLink: value,
                type: homePageResponseProductImages[index].type), (model) {
          getHomeApi();
        });
      }
    });
  }

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
                      alignment: Alignment.center, child: Text('名稱')))),
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
          controller.homePageResponsePageViewImages.length,
          (index) => DataRow(
            cells: [
              DataCell(Text('第$index個')),
              DataCell(Row(
                children: [
                  Text(
                      'ID: ${controller.homePageResponsePageViewImages[index].id}'),
                ],
              )),
              DataCell(
                GestureDetector(
                  onTap: () {
                    controller.dataPageImageReplace(
                        index,
                        controller.homePageResponsePageViewImages[index].id,
                        controller
                            .homePageResponsePageViewImages[index].images);
                  },
                  child: CachedNetworkImage(
                    imageUrl:
                        controller.homePageResponsePageViewImages[index].images,
                    width: 120,
                    height: 120,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Container(),
                  ),
                ),
              ),
              DataCell(Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.dataPageNameReplace(index,
                          controller.homePageResponsePageViewImages[index].id);
                    },
                    child: Container(
                      constraints: BoxConstraints(minWidth: 10, maxWidth: 200),
                      child: Text(
                          '${controller.homePageResponsePageViewImages[index].name}'),
                    ),
                  ),
                ],
              )),
              DataCell(Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.dataPageDescriptionReplace(index,
                          controller.homePageResponsePageViewImages[index].id);
                    },
                    child: Container(
                      constraints: BoxConstraints(minWidth: 10, maxWidth: 200),
                      child: Text(
                          '${controller.homePageResponsePageViewImages[index].description}'),
                    ),
                  ),
                ],
              )),
              DataCell(Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.dataPageVideoLinkReplace(index,
                          controller.homePageResponsePageViewImages[index].id);
                    },
                    child: Container(
                      constraints: BoxConstraints(minWidth: 10, maxWidth: 200),
                      child: Text(
                          '${controller.homePageResponsePageViewImages[index].videoLink}'),
                    ),
                  ),
                ],
              )),
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
                      alignment: Alignment.center, child: Text('名稱')))),
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
          controller.homePageResponseProductImages.length,
          (index) => DataRow(
            cells: [
              DataCell(Text('第$index個')),
              DataCell(Text(
                  'ID: ${controller.homePageResponseProductImages[index].id}')),
              DataCell(
                GestureDetector(
                  onTap: () {
                    controller.dataPageImageReplace(
                        index,
                        controller.homePageResponsePageViewImages[index].id,
                        controller
                            .homePageResponsePageViewImages[index].images);
                  },
                  child: CachedNetworkImage(
                    imageUrl:
                        controller.homePageResponseProductImages[index].images,
                    width: 120,
                    height: 120,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Container(),
                  ),
                ),
              ),
              DataCell(GestureDetector(
                onTap: () {
                  controller.dataProductNameReplace(index,
                      controller.homePageResponseProductImages[index].id);
                },
                child: Container(
                  constraints: BoxConstraints(minWidth: 10, maxWidth: 200),
                  child: Text(
                      '${controller.homePageResponseProductImages[index].name}'),
                ),
              )),
              DataCell(GestureDetector(
                onTap: () {
                  controller.dataProductDescriptionReplace(index,
                      controller.homePageResponseProductImages[index].id);
                },
                child: Container(
                  constraints: BoxConstraints(minWidth: 10, maxWidth: 200),
                  child: Text(
                      '${controller.homePageResponseProductImages[index].description}'),
                ),
              )),
              DataCell(GestureDetector(
                onTap: () {
                  controller.dataProductVideoLinkReplace(index,
                      controller.homePageResponseProductImages[index].id);
                },
                child: Container(
                  constraints: BoxConstraints(minWidth: 10, maxWidth: 200),
                  child: Text(
                      '${controller.homePageResponseProductImages[index].videoLink}'),
                ),
              )),
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
