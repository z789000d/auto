import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:web_auto/page/backend/about_us_backend_page.dart';
import 'package:web_auto/page/backend/catalogue_backend_page.dart';
import 'package:web_auto/page/backend/contact_us_backend_page.dart';
import 'package:web_auto/page/backend/home_backend_page.dart';
import 'package:web_auto/page/backend/news_backend_page.dart';
import 'package:web_auto/page/backend/product_list_backend_page.dart';
import 'package:web_auto/page/frontend/about_us.dart';
import 'package:web_auto/page/frontend/catalogue_list.dart';
import 'package:web_auto/page/frontend/contact_us.dart';
import 'package:web_auto/page/frontend/home_page.dart';
import 'package:web_auto/page/frontend/news_page.dart';
import 'package:web_auto/page/frontend/product_list.dart';

class Utils {
  static final testImage = <String>[
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
  ];


  static String? getYouTubeVideoId(String videoUrl) {
    // YouTube 影片連結的正則表達式模式
    RegExp regExp = RegExp(
      r'^(?:https?:\/\/)?(?:www\.)?'
      r'(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))'
      r'([^?&]+)(?:\?t=.+)?(?:\?.+)?$',
    );

    // 檢查連結是否符合 YouTube 影片的格式
    if (regExp.hasMatch(videoUrl)) {
      // 提取影片 ID
      String videoId = regExp.firstMatch(videoUrl)?.group(1) ?? '';
      return videoId;
    } else {
      // 非有效的 YouTube 影片連結
      return null;
    }
  }

  static void clickButton(int index) {
    print('$index');
    if (index == 0) {
      Get.delete<PageControllerMixin>();
      Get.to(MyHomePage());
    }
    if (index == 1) {
      Get.delete<AboutController>();
      Get.to(AboutUsPage());
    }
    if (index == 2) {
      Get.delete<ProductListController>();
      Get.to(ProductListPage());
    }
    if (index == 3) {
      Get.delete<NewsController>();
      Get.to(NewsPage());
    }
    if (index == 4) {
      Get.delete<CatalogueController>();
      Get.to(CatalogueListPage());
    }
    if (index == 5) {
      Get.delete<ContactUsController>();
      Get.to(ContactUsPage());
    }
    if (index == 6) {
      Get.delete<HomePageBackedController>();
      Get.to(HomeBackendPage());
    }
  }

  static void clickButtonBacked(int index) {
    print('$index');
    if (index == 0) {
      Get.delete<HomePageBackedController>();
      Get.to(HomeBackendPage());
    }
    if (index == 1) {
      Get.delete<AboutUsBackendController>();
      Get.to(AboutUsBackendPage());
    }
    if (index == 2) {
      Get.delete<ProductListBackendController>();
      Get.to(ProductListBackendPage());
    }
    if (index == 3) {
      Get.delete<NewsBackedController>();
      Get.to(NewsBackendPage());
    }
    if (index == 4) {
      Get.delete<CatalogueBackendController>();
      Get.to(CatalogueBackendPage());
    }
    if (index == 5) {
      Get.delete<ContactUsBackendController>();
      Get.to(ContactUsBackendPage());
    }
    if (index == 6) {
      Get.delete<PageControllerMixin>();
      Get.to(MyHomePage());
    }
  }
}
