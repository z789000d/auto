import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:web_auto/api/product_page_api.dart';
import 'package:web_auto/model/product_model.dart';
import 'package:web_auto/page/frontend/parent_page.dart';
import 'package:web_auto/page/frontend/product_detail_page.dart';
import 'package:web_auto/widget/top_bar_widget.dart';
import '../../main.dart';
import '../../utils.dart';
import '../../widget/bottom_bar_widget.dart';
import '../../widget/change_page_widget.dart';

class ProductListController extends GetxController {
  final productPageResponseModel = ProductResponseModel(code: 0, data: []).obs;
  RxList<ProductPageData> productShowModel = <ProductPageData>[].obs;

  final pageViewImage = Utils.testImage.obs;

  final nowPageIndex = 1.obs;

  @override
  void onInit() {
    super.onInit();

    getApi();
  }

  void getApi() {
    EasyLoading.show();
    ProductPageApi().postApi(ProductRequestModel(action: '0'), (model) {
      productPageResponseModel.value = model;
      setGridValue(1);
      EasyLoading.dismiss();
    });
  }

  void getApiFromType(String category) {
    EasyLoading.show();
    ProductPageApi().postApi(ProductRequestModel(action: '0'), (model) {
      productPageResponseModel.value = model;
      productPageResponseModel.value.data = model.data
          .where((element) => element.category.contains(category))
          .toList();
      setGridValue(1);
      EasyLoading.dismiss();
    });
  }

  RxInt currentIndex = RxInt(-1);

  RxInt categoryIndex = RxInt(-1);

  RxInt nowCategoryIndex = RxInt(0);

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }

  void setCategoryIndex(int index) {
    categoryIndex.value = index;
  }

  void setNowCategoryIndex(int index) {
    nowCategoryIndex.value = index;
  }

  void setGridValue(int index) {
    nowPageIndex.value = index - 1;
    int startIndex = (index - 1) * 9;
    int endIndex = startIndex + 8;
    if (endIndex + 1 > productPageResponseModel.value.data.length) {
      endIndex = productPageResponseModel.value.data.length - 1;
    }
    productShowModel.value =
        productPageResponseModel.value.data.sublist(startIndex, endIndex + 1);
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
          '產品列表',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 20),
        categoryWidget(),
        productListImageWidget(),
      ],
    );
  }

  Widget categoryWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          margin: EdgeInsets.only(left: 40, top: 10, bottom: 10, right: 40),
          child: Row(
            children: [
              Container(
                width: Get.width / 1.2,
                height: 30,
                alignment: Alignment.centerLeft,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: Utils.category.length,
                  itemBuilder: (BuildContext context, int index) {
                    return categoryItemWidget(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget categoryItemWidget(index) {
    return Obx(
      () => MouseRegion(
        onEnter: (event) {
          controller.setCategoryIndex(index);
          print('aaaaa ${controller.categoryIndex.value} ${index}');
        },
        onExit: (event) {
          controller.setCategoryIndex(-1);
          print('aaaaa ${index}');
        },
        child: GestureDetector(
          onTap: () {
            if (index == 0) {
              controller.getApi();
            } else {
              controller.getApiFromType(Utils.category[index]);
            }
            controller.setNowCategoryIndex(index);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              // 设置圆角半径
              color: controller.nowCategoryIndex == index
                  ? Colors.red
                  : ((controller.categoryIndex.value == index)
                      ? Colors.blue
                      : Colors.white),
              border: Border.all(
                color: Colors.black, // 边框颜色
                width: 1, // 边框宽度
              ),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text(
              Utils.category[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: controller.nowCategoryIndex == index
                    ? Colors.white
                    : ((controller.categoryIndex.value == index)
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget productListImageWidget() {
    return Obx(() {
      final int itemCount =
          controller.productPageResponseModel.value.data.length;
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
          changePageWidget(
              controller.productPageResponseModel.value.data.length,
              (pageIndex) {
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
            Get.delete<ProductDetailController>();

            final ProductDetailController productDetailController =
                Get.put(ProductDetailController());

            productDetailController.productModel.value =
                controller.productPageResponseModel.value.data[index];
            productDetailController.productPageResponseModel.value =
                controller.productPageResponseModel.value;
            Get.to(ProductDetailPage());
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
                          .productShowModel[index].imageData[0].imageUrl!)),
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
