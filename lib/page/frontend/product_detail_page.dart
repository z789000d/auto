import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/page/frontend/parent_page.dart';
import 'package:web_auto/page/frontend/product_list.dart';
import 'package:web_auto/widget/top_bar_widget.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../main.dart';
import '../../model/product_model.dart';
import '../../utils.dart';
import '../../widget/bottom_bar_widget.dart';

class ProductDetailController extends GetxController {
  final CarouselController buttonCarouselController = CarouselController();
  final productPageResponseModel = ProductResponseModel(code: 0, data: []).obs;
  final Rx<ProductPageData> productModel = ProductPageData(
          id: 0,
          category: '',
          name: '',
          imageData: [],
          description: '',
          videoLink: '')
      .obs;

  final currentPageIndex = 0.obs;

  RxInt currentIndex = RxInt(-1);

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }

  var ytController = YoutubePlayerController.fromVideoId(
    videoId: '',
    autoPlay: false,
    params: const YoutubePlayerParams(showFullscreenButton: true),
  ).obs;

  @override
  void onInit() {
    super.onInit();
    ytController.value = YoutubePlayerController.fromVideoId(
      videoId: '${Utils.getYouTubeVideoId(productModel.value.videoLink)}',
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class ProductDetailPage extends ParentPage {
  ProductDetailPage({super.key});

  final ProductDetailController controller = Get.put(ProductDetailController());

  @override
  Widget childWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Obx(
            () => Container(
              height: 350,
              width: Get.width.obs.value / 1.5,
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
                items: controller.productModel.value.imageData.map((image) {
                  return Image.network(image.imageUrl!);
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
                      i < controller.productModel.value.imageData.length;
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
          buildProductList(),
        ],
      ),
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
                width: 400,
                height: 225,
                child: YoutubePlayer(
                  controller: controller.ytController.value,
                  aspectRatio: 16 / 9,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildProductList() {
    return Visibility(
      visible: controller.productPageResponseModel.value.data.isNotEmpty
          ? true
          : false,
      child: Column(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                '相關產品:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5), // 添加圆角
            ),
            height: 210,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.productPageResponseModel.value.data.length,
              itemBuilder: (BuildContext context, int index) {
                return listViewItem(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget listViewItem(index) {
    return Container(
      width: 200,
      height: 200,
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
      child: Obx(
        () => MouseRegion(
          onEnter: (event) {
            controller.setCurrentIndex(index);
          },
          onExit: (event) {
            controller.setCurrentIndex(-1);
          },
          child: GestureDetector(
            onTap: () {
              Get.delete<ProductListController>();

              final ProductDetailController productDetailController =
                  Get.put(ProductDetailController());

              productDetailController.productPageResponseModel.value =
                  controller.productPageResponseModel.value;
              productDetailController.productPageResponseModel.value =
                  controller.productPageResponseModel.value;
              Get.to(ProductDetailPage());

              Get.to(ProductListPage());
            },
            child: Container(
              child: Column(
                children: [
                  Expanded(
                      child: Image.network(controller.productPageResponseModel
                          .value.data[index].imageData[0].imageUrl!)),
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
                        controller
                            .productPageResponseModel.value.data[index].name,
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
