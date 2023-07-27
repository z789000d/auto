import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/model/bus_model.dart';
import 'package:web_auto/model/home_page_model.dart';
import 'package:web_auto/model/product_model.dart';
import 'package:web_auto/page/frontend/parent_page.dart';
import 'package:web_auto/page/frontend/product_detail_page.dart';
import 'package:web_auto/widget/top_bar_widget.dart';

import '../../api/bus_api.dart';
import '../../utils.dart';
import '../../widget/bottom_bar_widget.dart';

class PageControllerMixin extends GetxController {
  final CarouselController buttonCarouselController = CarouselController();
  final currentPageIndex = 0.obs;
  final homePageModel =
      HomePageModel(pageViewImages: [], productImages: []).obs;

  final pageViewImage = Utils.testImage.obs;

  RxInt currentIndex = RxInt(-1);

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();

    BusApi().getApi((model) {
      print('aa ${model.data![0].city}');
    });

    for (var i = 0; i < 9; i++) {
      homePageModel.value.pageViewImages.add(ProductModel(
          id: i.toString(),
          category: i.toString(),
          name: "產品$i",
          images: Utils.testImage,
          description: "描述$i",
          videoLink: "連結$i"));

      homePageModel.value.productImages.add(ProductModel(
          id: i.toString(),
          category: i.toString(),
          name: "產品$i",
          images: Utils.testImage,
          description: "描述$i",
          videoLink: "連結$i"));
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class MyHomePage extends ParentPage {
  final PageControllerMixin controller = Get.put(PageControllerMixin());

  MyHomePage({super.key});

  @override
  Widget childWidget() {
    return Column(
      children: [
        Obx(
          () => Container(
            height: 350,
            width: Get.width / 1.5,
            child: CarouselSlider(
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  controller.currentPageIndex.value = index;
                },
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 4),
              ),
              items: controller.homePageModel.value.pageViewImages
                  .map((productModel) {
                return Image.network(productModel.images[0]);
              }).toList(),
              carouselController: controller.buttonCarouselController,
            ),
          ),
        ),
        Container(
          height: 20,
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0;
                    i < controller.homePageModel.value.pageViewImages.length;
                    i++)
                  Container(
                    margin: EdgeInsets.all(4),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i == controller.currentPageIndex.value
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
        ),
        Obx(
          () => GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Get.width.obs.value < 800 ? 1 : 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 8,
                childAspectRatio: Get.width.obs.value < 800
                    ? (Get.width.obs.value) / (Get.height.obs.value) * 2
                    : (Get.width.obs.value) / (Get.height.obs.value)),
            itemCount: controller.homePageModel.value.productImages.length,
            itemBuilder: (context, index) {
              return gridViewItem(index);
            },
          ),
        ),
      ],
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
            Get.to(ProductDetailPage(), arguments: {
              'productModel':
                  controller.homePageModel.value.productImages[index]
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
                      child: Image.network(controller
                          .homePageModel.value.productImages[index].images[0])),
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
                        '產品$index',
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
