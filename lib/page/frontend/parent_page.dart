import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:web_auto/widget/top_bar_widget.dart';

import '../../utils.dart';
import '../../widget/bottom_bar_widget.dart';


class ParentPage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ParentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: drawer(context),
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [TopBar(scaffoldKey), childWidget(), BottomWidget()],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget drawer(context) {
    return Drawer(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Image(image: AssetImage('assets/images/logo.png')),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            drawerItem(context, '首頁', 0),
            drawerItem(context, '關於我們', 1),
            drawerItem(context, '產品介紹', 2),
            drawerItem(context, '最新消息', 3),
            drawerItem(context, '電子型錄', 4),
            drawerItem(context, '聯絡我們', 5),
            SizedBox(
              width: 1,
              height: Get.height/8,
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

  Widget drawerItem(context, title, index) {
    return ListTile(
      title: Center(child: Text(title)),
      onTap: () {
        scaffoldKey.currentState!.closeDrawer();
        Utils.clickButton(index);
      },
    );
  }

  Widget childWidget() {
    return Container();
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }
}
