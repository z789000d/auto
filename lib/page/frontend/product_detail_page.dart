import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:web_auto/page/frontend/parent_page.dart';
import 'package:web_auto/widget/top_bar_widget.dart';

import '../../main.dart';
import '../../model/product_model.dart';
import '../../utils.dart';
import '../../widget/bottom_bar_widget.dart';

class ProductDetailController extends GetxController {
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

  RxList<ProductModel> productModelList = <ProductModel>[].obs;

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

    for (var i = 0; i < 10; i++) {
      productModelList.add(ProductModel(
          id: i.toString(),
          category: i.toString(),
          name: "產品$i",
          images: pageViewImage,
          description: "描述$i",
          videoLink: "連結$i"));
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class ProductDetailPage extends ParentPage {
  final ProductDetailController controller = Get.put(ProductDetailController());

  ProductDetailPage({super.key});

  @override
  Widget childWidget() {
    controller.productModel.value = Get.arguments['productModel']; // 獲取傳遞的參數
    return Column(
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
              items: controller.productModel.value.images.map((image) {
                return Image.network(image);
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
        buildProductList(),
      ],
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

  Widget buildProductList() {
    return Column(
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
            itemCount: controller.productModelList.length,
            itemBuilder: (BuildContext context, int index) {
              return listViewItem(index);
            },
          ),
        ),
      ],
    );
  }

  Widget listViewItem(index) {
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
              'productModel': controller.productModelList[index]
            });
          },
          child: Container(
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
            child: Container(
              child: Column(
                children: [
                  Expanded(
                      child: Image.network(
                          controller.productModelList[index].images[0])),
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
                        controller.productModelList[index].name,
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
