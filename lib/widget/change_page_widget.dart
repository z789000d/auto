import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/page/frontend/news_page.dart';

import '../page/frontend/about_us.dart';
import '../page/frontend/catalogue_list.dart';
import '../page/frontend/contact_us.dart';
import '../page/frontend/home_page.dart';
import '../page/frontend/product_list.dart';

Widget changePageWidget(
    int itemCount, void Function(int index) doSomething, int nowPageIndex) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List<Widget>.generate(
      (itemCount ~/ 9) + 1,
      (pageIndex) {
        return GestureDetector(
          onTap: () {
            doSomething(pageIndex);
          },
          child: Container(
            width: 20,
            height: 20,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: nowPageIndex == pageIndex ? Colors.blue : Colors.grey,
            ),
            child: Center(
              child: Text(
                '${pageIndex + 1}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
