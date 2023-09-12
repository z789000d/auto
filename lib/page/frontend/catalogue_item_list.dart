import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/model/catalogue_model.dart';
import 'package:web_auto/model/product_model.dart';
import 'package:web_auto/page/frontend/parent_page.dart';
import 'package:web_auto/widget/top_bar_widget.dart';

import '../../widget/bottom_bar_widget.dart';

class CatalogueItemController extends GetxController {
  final Rx<CataloguePageData> catalogueModel =
      CataloguePageData(id: 0, name: '', imageData: []).obs;

  final currentPageIndex = 0.obs;

  RxInt currentIndex = RxInt(-1);

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
  }
}

class CatalogueItemListPage extends ParentPage {
  final CatalogueItemController controller = Get.put(CatalogueItemController());

  CatalogueItemListPage({super.key});

  @override
  Widget childWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 20),
        Text(
          controller.catalogueModel.value.name,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 20),
        productListImageWidget(),
      ],
    );
  }

  Widget productListImageWidget() {
    return Obx(
      () => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Get.width.obs.value < 720 ? 1 : 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 8,
            childAspectRatio: Get.width.obs.value < 720
                ? (Get.width.obs.value) / (Get.width) * 2
                : (Get.width.obs.value) / (Get.height.obs.value)),
        itemCount: controller.catalogueModel.value.imageData.length,
        itemBuilder: (context, index) {
          return gridViewItem(index);
        },
      ),
    );
  }

  Widget gridViewItem(index) {
    return Obx(
      () => MouseRegion(
        onEnter: (event) {
          controller.setCurrentIndex(index);
        },
        onExit: (event) {
          controller.setCurrentIndex(-1);
        },
        child: GestureDetector(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(40),
            decoration: BoxDecoration(
              border: Border.all(
                color: controller.currentIndex.value == index
                    ? Colors.blue
                    : Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(5), // 添加圆角
            ),
            child: Container(
              child: Column(
                children: [
                  Expanded(
                      child: Image.network(controller
                          .catalogueModel.value.imageData[index].imageUrl!)),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: controller.currentIndex.value == index
                            ? Colors.blue
                            : Colors.grey, // 添加圆角
                      ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        '目錄 ${controller.catalogueModel.value.name}',
                        style: TextStyle(
                            fontSize: 20,
                            color: controller.currentIndex.value == index
                                ? Colors.white
                                : Colors.black),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
