import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/model/news_page_model.dart';
import 'package:web_auto/page/frontend/parent_page.dart';
import 'package:web_auto/widget/top_bar_widget.dart';

import '../../main.dart';
import '../../model/product_model.dart';
import '../../utils.dart';
import '../../widget/bottom_bar_widget.dart';
import '../../widget/change_page_widget.dart';

class NewsController extends GetxController {
  RxList<NewsModel> newModel = <NewsModel>[].obs;
  RxList<NewsModel> newShowModel = <NewsModel>[].obs;

  final RxInt hoveredIndex = RxInt(-1);
  final nowPageIndex = 1.obs;

  @override
  void onInit() {
    super.onInit();
    for (var i = 0; i < 12; i++) {
      newModel.add(NewsModel(date: "2023/7/11", news: "最新消息$i"));
    }

    setNewsValue(1);
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setNewsValue(int index) {
    nowPageIndex.value = index - 1;
    int startIndex = (index - 1) * 10;
    int endIndex = startIndex + 9;
    if (endIndex + 1 > newModel.length) {
      endIndex = newModel.length - 1;
    }
    newShowModel.value = newModel.sublist(startIndex, endIndex + 1);
  }
}

class NewsPage extends ParentPage {
  final NewsController controller = Get.put(NewsController());

  NewsPage({super.key});

  @override
  Widget childWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 20),
        Text(
          '最新消息',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Colors.blue,
          ),
        ),
        newsItemWidget(),
      ],
    );
  }

  Widget newsItemWidget() {
    return Obx(
      () => Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: controller.newShowModel.length,
            itemBuilder: (context, index) {
              return MouseRegion(
                onEnter: (_) {
                  print('aaa ${index}');
                  controller.hoveredIndex.value = index;
                },
                onExit: (_) {
                  controller.hoveredIndex.value = -1;
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  // 設定底部間距
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ), // 添加底線
                  ),
                  child: textWidget(controller.newShowModel[index], index),
                ),
              );
            },
          ),
          heightBox(),
          changePageWidget(controller.newModel.length, (pageIndex) {
            scrollToTop();
            controller.setNewsValue(pageIndex + 1);
          }, controller.nowPageIndex.value),
        ],
      ),
    );
  }

  Widget textWidget(NewsModel newsModel, int index) {
    return Obx(() => Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Text(
                newsModel.date,
                style: TextStyle(
                  fontWeight: controller.hoveredIndex.value == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  newsModel.news,
                  style: TextStyle(
                    fontWeight: controller.hoveredIndex.value == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget heightBox() {
    if (controller.newShowModel.length <= 3) {
      return SizedBox(
        width: 0,
        height: 350,
      );
    } else if (controller.newShowModel.length <= 6) {
      return SizedBox(
        width: 0,
        height: 200,
      );
    } else {
      return SizedBox(
        width: 0,
        height: 0,
      );
    }
  }
}
