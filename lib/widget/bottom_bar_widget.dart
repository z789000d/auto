import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:web_auto/page/contact_us.dart';

import '../page/about_us.dart';
import '../page/home_page.dart';

class BottomController extends GetxController {
  final buttonStates = List.generate(6, (_) => false).obs;
  final hoverIndex = RxInt(-1);

  void clickButton(int index) {
    if (index == 0) {
      Get.to(MyHomePage());
    }
    if (index == 1) {
      Get.to(AboutUsPage());
    }
    if (index == 5) {
      Get.to(ContactUsPage());
    }
  }

  void updateButtonState(int index, bool isSelected) {
    buttonStates[index] = isSelected;
  }

  void updateHoverIndex(int index) {
    hoverIndex.value = index;
  }
}

class BottomWidget extends StatelessWidget {
  final BottomController bottomController = Get.put(BottomController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('公司地址:新竹市千甲路191號'),
                SizedBox(height: 8.0),
                Text('電話:035-723504'),
                SizedBox(height: 8.0),
                Text('傳真:035-745523'),
                SizedBox(height: 8.0),
                Text('電子郵件:tinh@ms12.hinet.net')
              ],
            ),
          ),
          SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  buildButton('．首頁', bottomController.buttonStates[0], 0),
                  SizedBox(width: 8.0),
                  buildButton('．關於我們', bottomController.buttonStates[0], 1),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  buildButton('．產品介紹', bottomController.buttonStates[1], 2),
                  SizedBox(width: 8.0),
                  buildButton('．最新消息', bottomController.buttonStates[2], 3),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  buildButton('．電子型錄', bottomController.buttonStates[3], 4),
                  SizedBox(width: 8.0),
                  buildButton('．聯絡我們', bottomController.buttonStates[4], 5),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButton(String title, bool isSelected, int index) {
    final BottomController bottomController = Get.find<BottomController>();

    return MouseRegion(
      onEnter: (_) {
        bottomController.updateHoverIndex(index);
      },
      onExit: (_) {
        bottomController.updateHoverIndex(-1);
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          bottomController.clickButton(index);
        },
        child: Obx(() {
          bool isHovered = bottomController.hoverIndex.value == index;

          return Container(
            width: 120,
            margin: EdgeInsets.only(bottom: 8.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isHovered || isSelected
                      ? Colors.black
                      : Colors.transparent,
                  width: 2.0,
                ),
              ),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        }),
      ),
    );
  }
}
