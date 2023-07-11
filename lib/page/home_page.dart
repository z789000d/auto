import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/widget/top_bar_widget.dart';

import '../main.dart';
import '../widget/bottom_bar_widget.dart';

class PageControllerMixin extends GetxController {
  final RxDouble nowConstraintsWidth = 0.0.obs;
  final RxDouble nowConstraintsHeight = 0.0.obs;

  final CarouselController buttonCarouselController = CarouselController();
  final currentPageIndex = 0.obs;
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

  RxInt currentIndex = RxInt(-1);

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    // 初始化操作
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class MyHomePage extends StatelessWidget {
  final PageControllerMixin controller = Get.put(PageControllerMixin());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        controller.nowConstraintsWidth.value = constraints.maxWidth;
        controller.nowConstraintsHeight.value = constraints.maxHeight;
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TopBar(),
                    Container(
                      height: 350,
                      width: MediaQuery.of(context).size.width,
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
                        items: controller.pageViewImage.map((image) {
                          return Image.network(image);
                        }).toList(),
                        carouselController: controller.buttonCarouselController,
                      ),
                    ),
                    Container(
                      height: 20,
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0;
                                i < controller.pageViewImage.length;
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                controller.nowConstraintsWidth.value < 720
                                    ? 1
                                    : 3,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 8,
                            childAspectRatio: controller
                                        .nowConstraintsWidth.value <
                                    720
                                ? (controller.nowConstraintsWidth.value) /
                                    (controller.nowConstraintsHeight.value) *
                                    2
                                : (controller.nowConstraintsWidth.value) /
                                    (controller.nowConstraintsHeight.value)),
                        itemCount: controller.pageViewImage.length,
                        itemBuilder: (context, index) {
                          return gridViewItem(index);
                        },
                      ),
                    ),
                    BottomWidget()
                  ],
                ),
              ),
            ),
          ],
        );
      }),
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
                Expanded(child: Image.network(controller.pageViewImage[index])),
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
    );
  }
}
