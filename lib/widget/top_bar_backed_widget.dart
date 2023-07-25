import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/page/frontend/news_page.dart';

import '../page/frontend/about_us.dart';
import '../page/frontend/catalogue_list.dart';
import '../page/frontend/contact_us.dart';
import '../page/frontend/home_page.dart';
import '../page/frontend/parent_page.dart';
import '../page/frontend/product_list.dart';
import '../utils.dart';

final TopBarBackedController topBarController =
    Get.put(TopBarBackedController());

class TopBarBackedController extends GetxController {
  final buttonStates =
      <bool>[false, false, false, false, false, false, false].obs;

  void updateButtonState(int index, bool isHovered) {
    buttonStates[index] = isHovered;
  }
}

class TopBarBacked extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return buildRowOfButtons();
    });
  }

  Widget buildRowOfButtons() {
    return Obx(
      () => Container(
        color: Colors.grey,
        width: Get.width.obs.value,
        height: 150,
        padding: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 30),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Image(image: AssetImage('assets/images/logo.png')),
            ),
            Container(
              width: (Get.width / 1.5) < 800 ? 800 : Get.width / 1.2,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildButton('首頁後台', topBarController, 0),
                  buildButton('關於我們後台', topBarController, 1),
                  buildButton('產品介紹後台', topBarController, 2),
                  buildButton('最新消息後台', topBarController, 3),
                  buildButton('電子型錄後台', topBarController, 4),
                  buildButton('聯絡我們後台', topBarController, 5),
                  buildButton('回主畫面', topBarController, 6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(
      String title, TopBarBackedController controller, int index) {
    bool isHovered = controller.buttonStates[index];
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
          Utils.clickButtonBacked(index);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Visibility(
              visible: isHovered,
              replacement: SizedBox(
                width: 90,
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
  }
}
