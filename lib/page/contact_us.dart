import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:web_auto/widget/top_bar_widget.dart';
import '../main.dart';
import '../widget/bottom_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;
class ContactUsController extends GetxController {
  final RxDouble nowConstraintsWidth = 0.0.obs;
  final RxDouble nowConstraintsHeight = 0.0.obs;

}

class ContactUsPage extends StatelessWidget {
  final ContactUsController controller = Get.put(ContactUsController());

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
                      Text(
                        '聯絡我們',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                          color: Colors.blue,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          html.window.open('https://www.google.com/maps/place/300%E6%96%B0%E7%AB%B9%E5%B8%82%E6%9D%B1%E5%8D%80%E5%8D%83%E7%94%B2%E8%B7%AF191%E8%99%9F/@24.8078474,121.002004,17z/data=!3m1!4b1!4m6!3m5!1s0x34683665d50c0411:0x1f9f911e0006914f!8m2!3d24.8078474!4d121.0045789!16s%2Fg%2F11c5jzrg_c?hl=zh-TW&entry=ttu','_blank');
                        },
                        child: Container(
                          color: Colors.blue,
                          width: Get.width / 3,
                          height: Get.height / 3,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        width: Get.width,
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '鋸開自動化有限公司',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.normal,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              '公司地址:新竹市千甲路191號',
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '電話:035-723504',
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '傳真:035-745523',
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '電子郵件:tinh@ms12.hinet.net',
                              textAlign: TextAlign.start,
                            )
                          ],
                        ),
                      ),
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
}
