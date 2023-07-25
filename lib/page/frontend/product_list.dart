import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/model/product_model.dart';
import 'package:web_auto/page/frontend/parent_page.dart';
import 'package:web_auto/page/frontend/product_detail_page.dart';
import 'package:web_auto/widget/top_bar_widget.dart';
import '../../main.dart';
import '../../utils.dart';
import '../../widget/bottom_bar_widget.dart';
import '../../widget/change_page_widget.dart';

class ProductListController extends GetxController {
  RxList<ProductModel> productModel = <ProductModel>[].obs;

  RxList<ProductModel> productShowModel = <ProductModel>[].obs;

  final pageViewImage = Utils.testImage.obs;

  final nowPageIndex = 1.obs;

  @override
  void onInit() {
    super.onInit();

    for (var i = 0; i < 24; i++) {
      productModel.add(ProductModel(
          id: i.toString(),
          category: i.toString(),
          name: "產品$i",
          images: pageViewImage,
          description: "描述$i",
          videoLink: "連結$i"));
    }

    setGridValue(1);
  }

  RxInt currentIndex = RxInt(-1);

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }

  void setGridValue(int index) {
    nowPageIndex.value = index - 1;
    int startIndex = (index - 1) * 9;
    int endIndex = startIndex + 8;
    if (endIndex + 1 > productModel.length) {
      endIndex = productModel.length - 1;
    }
    productShowModel.value = productModel.sublist(startIndex, endIndex + 1);
  }
}

class ProductListPage extends ParentPage {
  final ProductListController controller = Get.put(ProductListController());

  ProductListPage({super.key});

  @override
  Widget childWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 20),
        Text(
          '產品介紹',
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
      final int itemCount = controller.productModel.length;
      final int showItemCount = controller.productShowModel.length;

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
                  : (Get.width.obs.value) / (Get.height.obs.value),
            ),
            itemCount: showItemCount,
            itemBuilder: (context, index) {
              return gridViewItem(index);
            },
          ),
          heightBox(),
          changePageWidget(controller.productModel.length, (pageIndex) {
            scrollToTop();
            controller.setGridValue(pageIndex + 1);
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
            Get.to(ProductDetailPage(), arguments: {
              'productModel': controller.productShowModel[index]
            });
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
                      child: Image.network(
                          controller.productShowModel[index].images[0])),
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
                        controller.productShowModel[index].name,
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
    if (controller.productShowModel.length <= 3) {
      return SizedBox(
        width: 0,
        height: 300,
      );
    } else if (controller.productShowModel.length <= 6) {
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
