import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/model/catalogue_model.dart';
import 'package:web_auto/widget/bottom_bar_widget.dart';
import 'package:web_auto/widget/top_bar_widget.dart';

import '../../widget/top_bar_backed_widget.dart';

// 定义控制器类
class CatalogueImageBackendController extends GetxController {
  Rx<CatalogueModel> catalogueModel =
      CatalogueModel(id: '', name: '', images: []).obs; // or
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
  }

  void addData() {
    CatalogueModel catalogueModelOriginal = catalogueModel.value.copyWith();
    catalogueModelOriginal.images.add(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU');
    catalogueModel.value = catalogueModelOriginal;
    scrollToEnd();
  }

  void deleteData(int index) {
    CatalogueModel catalogueModelOriginal = catalogueModel.value.copyWith();
    catalogueModelOriginal.images.removeAt(index);
    catalogueModel.value = catalogueModelOriginal;
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

class CatalogueImageBackendPage extends StatelessWidget {
  final CatalogueImageBackendController controller =
      Get.put(CatalogueImageBackendController());

  @override
  Widget build(BuildContext context) {
    // 使用GetX来获取控制器实例
    controller.catalogueModel.value =
        Get.arguments['catalogueModel']; // 獲取傳遞的參數
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
          controller.catalogueModel.value.images.length,
          (index) => DataRow(
            cells: [
              DataCell(Text('第$index個')),
              DataCell(Text('ID: ${controller.catalogueModel.value.id}')),
              DataCell(
                Image.network(
                  controller.catalogueModel.value.images[index],
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
                          if (index > 0) {
                            controller.catalogueModel.value.images.insert(
                                index - 1,
                                controller.catalogueModel.value.images
                                    .removeAt(index));
                          }
                        },
                        child: Text('上升')),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: GestureDetector(
                        onTap: () {
                          if (index <
                              controller.catalogueModel.value.images.length -
                                  1) {
                            controller.catalogueModel.value.images.insert(
                                index + 1,
                                controller.catalogueModel.value.images
                                    .removeAt(index));
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
