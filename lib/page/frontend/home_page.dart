import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/api/home_page_api.dart';
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
  final homePageResponseModel = HomePageResponseModel(code: 0, data: []).obs;
  final List<ProductData> homePageResponsePageViewImages = [
    ProductData(
        category: '',
        name: '',
        images: '',
        description: '',
        videoLink: '',
        id: 0,
        type: '')
  ].obs;
  final List<ProductData> homePageResponseProductImages = [
    ProductData(
        category: '',
        name: '',
        images: '',
        description: '',
        videoLink: '',
        id: 0,
        type: '')
  ].obs;
  final pageViewImage = Utils.testImage.obs;

  RxInt currentIndex = RxInt(-1);

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
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

      print('aaaa ${homePageResponsePageViewImages}');
      print('bbb ${homePageResponseProductImages}');
    });
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
              items:
                  controller.homePageResponsePageViewImages.map((productModel) {
                return CachedNetworkImage(
                  imageUrl: productModel.images,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Container(),
                );
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
                    i < controller.homePageResponsePageViewImages.length;
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
            itemCount: controller.homePageResponseProductImages.length,
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
                  controller.homePageResponseProductImages[index].images
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
                      child: CachedNetworkImage(
                    imageUrl:
                        controller.homePageResponseProductImages[index].images,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Container(),
                  )),
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
