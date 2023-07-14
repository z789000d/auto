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

class NewsController extends GetxController {
  final textList = <String>[].obs;
  final RxInt hoveredIndex = RxInt(-1);

  @override
  void onInit() {
    super.onInit();
    for (var i = 0; i < 10; i++) {
      textList.add("最新消息$i");
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class NewsPage extends ParentPage {
  final NewsController controller = Get.put(NewsController());

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
        Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: controller.textList.length,
            itemBuilder: (context, index) {
              final text = controller.textList[index];
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
                  child: textWidget(text, index),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget textWidget(String text, int index) {
    return Obx(() => Text(
          text,
          style: TextStyle(
            fontWeight: controller.hoveredIndex.value == index
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ));
  }
}
