import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_page.dart';

class FirstController extends GetxController {}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Delay the navigation until after the build is complete
        Future.delayed(Duration(seconds: 3), () {
          Get.off(MyHomePage());
        });
      });
      return Scaffold(
        body: Center(
          child: Container(
            color: Colors.blue,
            width: Get.width,
            height: Get.height,
            child: AnimatedOpacity(
              duration: Duration(seconds: 3),
              opacity: 1,
              child: ClipOval(
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 300,
                  height: 300,
                ),
              ),
              curve: Curves.ease,
            ),
          ),
        ),
      );
    });
  }
}
