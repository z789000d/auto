import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_page.dart';

class FirstController extends GetxController {
  var isVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Delay execution by two seconds
    Timer(Duration(seconds: 1), () {
      // Update the isVisible value to true
      isVisible.value = true;
    });
  }
}

class FirstPage extends StatelessWidget {
  final FirstController controller = Get.put(FirstController());

  FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Delay the navigation until after the build is complete
        Future.delayed(Duration(seconds: 2), () {
          Get.delete<FirstController>();
          Get.offAll(MyHomePage());
        });
      });
      return Scaffold(
          body: Center(
        child: Container(
          color: Colors.blue,
          width: Get.width,
          height: Get.height,
          child: Obx(
            () => AnimatedOpacity(
              duration: Duration(milliseconds: 1000),
              opacity: controller.isVisible.value ? 1 : 0,
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
      ));
    });
  }
}
