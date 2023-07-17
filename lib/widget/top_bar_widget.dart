import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/page/frontend/news_page.dart';

import '../page/frontend/about_us.dart';
import '../page/frontend/catalogue_list.dart';
import '../page/frontend/contact_us.dart';
import '../page/frontend/home_page.dart';
import '../page/frontend/product_list.dart';

class TopBarController extends GetxController {
  final buttonStates = <bool>[false, false, false, false, false, false].obs;

  void updateButtonState(int index, bool isHovered) {
    buttonStates[index] = isHovered;
  }

  void clickButton(int index) {
    print('$index');
    if (index == 0) {
      Get.delete<PageControllerMixin>();
      Get.to(MyHomePage());
    }
    if (index == 1) {
      Get.delete<AboutController>();
      Get.to(AboutUsPage());
    }
    if (index == 2) {
      Get.delete<ProductListController>();
      Get.to(ProductListPage());
    }
    if (index == 3) {
      Get.delete<NewsController>();
      Get.to(NewsPage());
    }
    if (index == 4) {
      Get.delete<CatalogueController>();
      Get.to(CatalogueListPage());
    }
    if (index == 5) {
      Get.delete<ContactUsController>();
      Get.to(ContactUsPage());
    }
  }
}

class TopBar extends StatelessWidget {
  final TopBarController topBarController = Get.put(TopBarController());

  TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return buildRowOfButtons();
  }

  Widget buildRowOfButtons() {
    return Obx(
      () => Container(
        color: Colors.blue,
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
              width: (Get.width / 1.5) < 600 ? 600 : Get.width / 1.5,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
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
      ),
    );
  }

  Widget buildButton(String title, TopBarController controller, int index) {
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
  }
}
