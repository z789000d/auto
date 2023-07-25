import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/page/frontend/login_page.dart';
import '../utils.dart';
import 'dart:html' as html;

final TopBarController topBarController = Get.put(TopBarController());

class TopBarController extends GetxController {
  final buttonStates =
      <bool>[false, false, false, false, false, false, false, false, false].obs;

  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getIsLogin();
  }

  void updateButtonState(int index, bool isHovered) {
    buttonStates[index] = isHovered;
  }

  void getIsLogin() {
    String savedData = html.window.localStorage['isLogin'] ?? "";
    print('${savedData} bbbbb');
    if (savedData == "true") {
      isLoggedIn.value = true;
    } else {
      isLoggedIn.value = false;
    }
  }

  void setIsLogin(String isLogin) {
    html.window.localStorage['isLogin'] = isLogin;
    isLoggedIn.value = isLogin == 'true' ? true : false;
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Get.width < 800 ? buildDrawer() : buildRowOfButtons();
    });
  }

  Widget buildDrawer() {
    return Builder(builder: (context) {
      return Container(
        height: 150,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                print('open');
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                color: Colors.blue,
                width: 150,
                height: 150,
                child: Icon(
                  Icons.list_outlined,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 150),
                color: Colors.blue,
                alignment: Alignment.center,
                child: Image(image: AssetImage('assets/images/logo.png')),
              ),
            ),
          ],
        ),
      );
    });
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
                  topBarController.isLoggedIn.value
                      ? buildButton('後台', topBarController, 6)
                      : buildButton('登入', topBarController, 7),
                  topBarController.isLoggedIn.value
                      ? buildButton('登出', topBarController, 8)
                      : Container()
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
          Utils.clickButton(index);
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
