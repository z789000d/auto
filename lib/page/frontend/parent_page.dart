import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/widget/top_bar_widget.dart';

import '../../widget/bottom_bar_widget.dart';

class ParentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [TopBar(), childWidget(), BottomWidget()],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget childWidget() {
    return Container();
  }
}