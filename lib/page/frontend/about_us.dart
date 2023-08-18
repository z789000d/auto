import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/api/about_us_page_api.dart';
import 'package:web_auto/page/frontend/parent_page.dart';
import 'package:web_auto/widget/top_bar_widget.dart';
import '../../main.dart';
import '../../model/about_us_model.dart';
import '../../widget/bottom_bar_widget.dart';

class AboutController extends GetxController {
  Rx<AboutUsResponseModel> aboutUsModel = AboutUsResponseModel(
          code: 0, aboutUsData: AboutUsData(imageData: [], text: ''))
      .obs;

  @override
  void onInit() {
    super.onInit();

    AboutUsPageApi().postApi(AboutUsRequestModel(action: 0), (model) {
      aboutUsModel.value = model;
    });
  }
}

class AboutUsPage extends ParentPage {
  final AboutController controller = Get.put(AboutController());

  AboutUsPage({super.key});

  @override
  Widget childWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 20),
        Text(
          '公司簡介',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 20),
        aboutUsTextWidget(),
        SizedBox(height: 20),
        aboutUsImageWidget(),
      ],
    );
  }

  Widget aboutUsTextWidget() {
    return Obx(
      () => Container(
        margin: EdgeInsets.all(10),
        child: Text(
          controller.aboutUsModel.value.aboutUsData.text!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          softWrap: false,
        ),
      ),
    );
  }

  Widget aboutUsImageWidget() {
    return Obx(
          () =>  Container(
        margin: EdgeInsets.all(40),
        child: GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Get.width.obs.value < 720 ? 1 : 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 8,
              childAspectRatio: Get.width.obs.value < 720
                  ? (Get.width.obs.value) / (Get.width.obs.value) * 2
                  : (Get.width.obs.value) / (Get.height.obs.value)),
          itemCount: controller.aboutUsModel.value.aboutUsData.imageData.length,
          itemBuilder: (context, index) {
            return Obx(
              () => Image.network(
                controller
                    .aboutUsModel.value.aboutUsData.imageData[index].imageUrl!,
                fit: BoxFit.contain,
              ),
            );
          },
        ),
      ),
    );
  }
}
