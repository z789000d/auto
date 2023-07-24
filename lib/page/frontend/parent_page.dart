import 'dart:html';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:web_auto/widget/top_bar_widget.dart';

import '../../utils.dart';
import '../../widget/bottom_bar_widget.dart';

class ParentPage extends StatelessWidget {
  final ScrollController scrollController = ScrollController();

  ParentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        drawer: drawer(context),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [TopBar(), childWidget(), BottomWidget()],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget drawer(context) {
    return Drawer(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DrawerHeader(
              child: Image(image: AssetImage('assets/images/logo.png')),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 7, // 项目数量
              itemBuilder: (context, index) {
                return drawerItem(context, index); // 这里可以根据index自行决定标题和操作
              },
            ),
            SizedBox(
              width: 1,
              height: Get.height / 5,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
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
            )
          ],
        ),
      ),
    );
  }

  Widget drawerItem(context, index) {
    var text = '';
    if (index == 0) {
      text = '首頁';
    } else if (index == 1) {
      text = '關於我們';
    } else if (index == 2) {
      text = '產品介紹';
    } else if (index == 3) {
      text = '最新消息';
    } else if (index == 4) {
      text = '電子型錄';
    } else if (index == 5) {
      text = '聯絡我們';
    } else if (index == 6) {
      text = '後台';
    }

    return ListTile(
      title: Center(child: Text(text)),
      onTap: () {
        Utils.clickButton(index);
        Scaffold.of(context).closeDrawer();
      },
    );
  }

  Widget childWidget() {
    return Container();
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }
}
