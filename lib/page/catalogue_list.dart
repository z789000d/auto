import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/model/catalogue_model.dart';
import 'package:web_auto/model/product_model.dart';
import 'package:web_auto/page/catalogue_item_list.dart';
import 'package:web_auto/page/product_detail_page.dart';
import 'package:web_auto/widget/top_bar_widget.dart';
import '../main.dart';
import '../widget/bottom_bar_widget.dart';

class CatalogueController extends GetxController {
  final RxDouble nowConstraintsWidth = 0.0.obs;
  final RxDouble nowConstraintsHeight = 0.0.obs;

  RxList<CatalogueModel> catalogueModel = <CatalogueModel>[].obs;

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
      catalogueModel.add(CatalogueModel(
          id: i.toString(), name: "型錄$i", images: pageViewImage));
    }
  }

  RxInt currentIndex = RxInt(-1);

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }
}

class CatalogueListPage extends StatelessWidget {
  final CatalogueController controller = Get.put(CatalogueController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
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
                      BottomWidget(),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget productListImageWidget() {
    return Obx(
      () => GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: controller.nowConstraintsWidth.value < 720 ? 1 : 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 8,
            childAspectRatio: controller.nowConstraintsWidth.value < 720
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
            print("aaaaaaa ${controller.catalogueModel[index]}");
            Get.to(CatalogueItemListPage(),
                arguments: {'catalogueModel': controller.catalogueModel[index]});
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
                          controller.catalogueModel[index].images[0])),
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
                        controller.catalogueModel[index].name,
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