import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/widget/bottom_bar_widget.dart';
import 'package:web_auto/widget/top_bar_widget.dart';

import '../../model/product_model.dart';
import '../../widget/top_bar_backed_widget.dart';

// 定义控制器类
class ProductImageBackedController extends GetxController {
  Rx<ProductModel> productModel = ProductModel(
          id: '',
          category: '',
          name: '',
          images: [],
          description: '',
          videoLink: '')
      .obs; // or
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
  }

  void addData() {
    ProductModel productModelOriginal = productModel.value.copyWith();
    productModelOriginal.images.add(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU');
    productModel.value = productModelOriginal;
    scrollToEnd();
  }

  void deleteData(int index) {
    ProductModel productModelOriginal = productModel.value.copyWith();
    productModelOriginal.images.removeAt(index);
    productModel.value = productModelOriginal;
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
    // 使用GetX来获取控制器实例
    controller.productModel.value = Get.arguments['productModel']; // 獲取傳遞的參數
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
          controller.productModel.value.images.length,
          (index) => DataRow(
            cells: [
              DataCell(Text('第$index個')),
              DataCell(Text('ID: ${controller.productModel.value.id}')),
              DataCell(
                Image.network(
                  controller.productModel.value.images[index],
                  width: 120,
                  height: 120,
                ),
              ),
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
