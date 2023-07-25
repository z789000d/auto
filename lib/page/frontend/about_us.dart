import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/page/frontend/parent_page.dart';
import 'package:web_auto/widget/top_bar_widget.dart';
import '../../main.dart';
import '../../model/about_us_model.dart';
import '../../widget/bottom_bar_widget.dart';

class AboutController extends GetxController {
  Rx<AboutUsModel> aboutUsModel = AboutUsModel(
      introduce: '',
      aboutUsImageModel: [AboutUsImageModel(id: '', images: '')]).obs;

  @override
  void onInit() {
    super.onInit();
    // 初始化数据

    AboutUsModel aboutUsModelOriginal = aboutUsModel.value.copyWith();
    aboutUsModelOriginal.aboutUsImageModel.clear();
    aboutUsModelOriginal.introduce =
        "鉅開公司創立於1993年專業製造、開發、設計自動化生產機械，範圍含括航太、汽車、電子、五金制品、娛樂、飲食等各行業生產器具。\n\n" +
            "公司位於臺灣科技工業區新竹，不僅擁有豐厚的科技資源做為後盾，更能隨時掌握世界脈動的訊息知識來構建您所需的一流產品。\n\n" +
            "我們秉持奉行『以人為本，科技興業，品質第一，服務至上，不斷創新』，提供最人性化、最經濟效益、最高品質服務的信念生產。責任意識、創業精神、誠信和優質服務更是我公司企業文化的精髓。\n\n" +
            "鉅開公司以不斷創新和提供優質服務，並持續專精技術、引進精密加工設備、人文管理科學的方式，期與顧客永恆發展為主要的經營理念。滿足顧客要求創建最好的產品品質方針，是我公司至今仍保有廣大客戶群的最高指導原則。\n\n" +
            "合作廠家遍及歐美、中東、中國大陸、臺灣、韓國、日本及東南亞地區，產品深獲信賴好評。\n\n";
    for (int i = 0; i < 10; i++) {
      aboutUsModelOriginal.aboutUsImageModel.add(AboutUsImageModel(
          id: '$i',
          images:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU'));
    }

    aboutUsModel.value = aboutUsModelOriginal;
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
          controller.aboutUsModel.value.introduce,
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
    return Container(
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
        itemCount: controller.aboutUsModel.value.aboutUsImageModel.length,
        itemBuilder: (context, index) {
          return Obx(
            () => Image.network(
              controller.aboutUsModel.value.aboutUsImageModel[index].images,
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
}
