import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/page/contact_us.dart';
import 'package:web_auto/page/home_page.dart';

import '../page/about_us.dart';
import '../page/product_list.dart';

class TopBarController extends GetxController {
  final buttonStates = <bool>[false, false, false, false, false, false].obs;

  void updateButtonState(int index, bool isHovered) {
    buttonStates[index] = isHovered;
  }

  void clickButton(int index) {
    if (index == 0) {
      Get.to(MyHomePage());
    }
    if (index == 1) {
      Get.to(AboutUsPage());
    }
    if (index == 2) {
      Get.to(ProductListPage());
    }
    if (index == 5) {
      Get.to(ContactUsPage());
    }
  }
}

class TopBar extends StatelessWidget {
  final TopBarController topBarController = Get.put(TopBarController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 30),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Icon(Icons.landscape_rounded),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButton('首頁', topBarController, 0),
                buildButton('關於我們', topBarController, 1),
                buildButton('產品介紹', topBarController, 2),
                buildButton('最新消息', topBarController, 3),
                buildButton('電子型錄', topBarController, 4),
                buildButton('聯絡我們', topBarController, 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(String title, TopBarController controller, int index) {
    return GetX<TopBarController>(
      init: controller,
      builder: (_) {
        bool isHovered = _.buttonStates[index];
        print('改');
        return MouseRegion(
          onEnter: (_) {
            controller.updateButtonState(index, true);
            print('enter');
          },
          onExit: (_) {
            controller.updateButtonState(index, false);
            print('exit');
          },
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              controller.clickButton(index);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Visibility(
                  visible: isHovered,
                  replacement: SizedBox(
                    width: 60,
                    height: 1,
                  ),
                  child: Container(
                    width: 60,
                    height: 1,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
