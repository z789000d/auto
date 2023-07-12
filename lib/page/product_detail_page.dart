import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:web_auto/widget/top_bar_widget.dart';

import '../main.dart';
import '../model/product_model.dart';
import '../utils.dart';
import '../widget/bottom_bar_widget.dart';

class ProductDetailController extends GetxController {
  final RxDouble nowConstraintsWidth = 0.0.obs;
  final RxDouble nowConstraintsHeight = 0.0.obs;

  final CarouselController buttonCarouselController = CarouselController();
  Rx<ProductModel> productModel = ProductModel(
          id: '',
          category: '',
          name: '',
          images: [],
          description: '',
          videoLink: '')
      .obs;

  final currentPageIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class ProductDetailPage extends StatelessWidget {
  final ProductDetailController controller = Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    controller.productModel.value = Get.arguments['productModel']; // 獲取傳遞的參數
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
                            controller.productModel.value.images.map((image) {
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
                                i < controller.productModel.value.images.length;
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
                    tableText(Get.context!),
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

  Widget tableText(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 10),
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    '產品名稱:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    controller.productModel.value.name,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    '產品類別:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    controller.productModel.value.category,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    '產品描述:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    controller.productModel.value.description,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    '影片連結:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: 320,
                height: 180,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: HtmlWidget(
                    '''<iframe width="560" height="315" src="https://www.youtube.com/embed/${Utils.getYouTubeVideoId("https://www.youtube.com/watch?v=TpX9aAfgurU")}" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>''',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
