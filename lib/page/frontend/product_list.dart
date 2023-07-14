import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/model/product_model.dart';
import 'package:web_auto/page/frontend/parent_page.dart';
import 'package:web_auto/page/frontend/product_detail_page.dart';
import 'package:web_auto/widget/top_bar_widget.dart';
import '../../main.dart';
import '../../widget/bottom_bar_widget.dart';

class ProductListController extends GetxController {
  RxList<ProductModel> productModel = <ProductModel>[].obs;

  final pageViewImage = <String>[
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
  ];

  @override
  void onInit() {
    super.onInit();

    for (var i = 0; i < 10; i++) {
      productModel.add(ProductModel(
          id: i.toString(),
          category: i.toString(),
          name: "產品$i",
          images: pageViewImage,
          description: "描述$i",
          videoLink: "連結$i"));
    }
  }

  RxInt currentIndex = RxInt(-1);

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }
}

class ProductListPage extends ParentPage {
  final ProductListController controller = Get.put(ProductListController());

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
    return Obx(
      () => GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Get.width.obs.value < 720 ? 1 : 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 8,
            childAspectRatio: Get.width.obs.value < 720
                ? (Get.width.obs.value) / (Get.height.obs.value) * 2
                : (Get.width.obs.value) / (Get.height.obs.value)),
        itemCount: controller.pageViewImage.length,
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
          onTap: () {
            print("aaaaaaa ${controller.productModel[index]}");
            Get.to(ProductDetailPage(),
                arguments: {'productModel': controller.productModel[index]});
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
                          controller.productModel[index].images[0])),
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
                        controller.productModel[index].name,
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