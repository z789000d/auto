import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/model/catalogue_model.dart';
import 'package:web_auto/model/product_model.dart';
import 'package:web_auto/page/frontend/parent_page.dart';
import 'package:web_auto/widget/top_bar_widget.dart';

import '../../api/catalogue_page_api.dart';
import '../../widget/bottom_bar_widget.dart';
import '../../widget/change_page_widget.dart';
import 'catalogue_item_list.dart';

class CatalogueController extends GetxController {
  final catalogueResponseModel = CatalogueResponseModel(code: 0, data: []).obs;
  RxList<CataloguePageData> catalogueShowModel = <CataloguePageData>[].obs;

  final nowPageIndex = 1.obs;
  RxInt currentIndex = RxInt(-1);

  @override
  void onInit() {
    super.onInit();
    getApi();
  }

  void getApi() {
    CataloguePageApi().postApi(CatalogueRequestModel(action: '0'), (model) {
      catalogueResponseModel.value = model;
      setCatalogueValue(1);
    });
  }

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }

  void setCatalogueValue(int index) {
    nowPageIndex.value = index - 1;
    int startIndex = (index - 1) * 9;
    int endIndex = startIndex + 8;
    if (endIndex + 1 > catalogueResponseModel.value.data.length) {
      endIndex = catalogueResponseModel.value.data.length - 1;
    }
    catalogueShowModel.value =
        catalogueResponseModel.value.data.sublist(startIndex, endIndex + 1);
  }
}

class CatalogueListPage extends ParentPage {
  final CatalogueController controller = Get.put(CatalogueController());

  CatalogueListPage({super.key});

  @override
  Widget childWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 20),
        Text(
          '電子型錄',
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
    return Obx(() {
      return Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Get.width.obs.value < 720 ? 1 : 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 8,
                childAspectRatio: Get.width.obs.value < 720
                    ? (Get.width.obs.value) / (Get.height.obs.value) * 2
                    : (Get.width.obs.value) / (Get.height.obs.value)),
            itemCount: controller.catalogueShowModel.length,
            itemBuilder: (context, index) {
              return gridViewItem(index);
            },
          ),
          heightBox(),
          changePageWidget(controller.catalogueResponseModel.value.data.length,
              (pageIndex) {
            scrollToTop();
            controller.setCatalogueValue(pageIndex + 1);
          }, controller.nowPageIndex.value),
        ],
      );
    });
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
          onTap: () {
            Get.delete<CatalogueItemController>();

            final CatalogueItemController catalogueItemController =
                Get.put(CatalogueItemController());

            catalogueItemController.catalogueModel.value =
                controller.catalogueShowModel[index];

            Get.to(CatalogueItemListPage());
          },
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
                          .catalogueShowModel[index].imageData[0].imageUrl!)),
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
                        controller.catalogueShowModel[index].name,
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

  Widget heightBox() {
    if (controller.catalogueShowModel.length <= 3) {
      return SizedBox(
        width: 0,
        height: 300,
      );
    } else if (controller.catalogueShowModel.length <= 6) {
      return SizedBox(
        width: 0,
        height: 150,
      );
    } else {
      return SizedBox(
        width: 0,
        height: 0,
      );
    }
  }
}
