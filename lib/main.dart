import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:web_auto/page/backend/about_us_backend_page.dart';
import 'package:web_auto/page/backend/catalogue_backend_page.dart';
import 'package:web_auto/page/backend/catalogue_image_backend_page.dart';
import 'package:web_auto/page/backend/contact_us_backend_page.dart';
import 'package:web_auto/page/backend/home_backend_page.dart';
import 'package:web_auto/page/backend/news_backend_page.dart';
import 'package:web_auto/page/backend/product_image_backend_page.dart';
import 'package:web_auto/page/backend/product_list_backend_page.dart';
import 'package:web_auto/page/frontend/about_us.dart';
import 'package:web_auto/page/frontend/catalogue_item_list.dart';
import 'package:web_auto/page/frontend/catalogue_list.dart';
import 'package:web_auto/page/frontend/contact_us.dart';
import 'package:web_auto/page/frontend/firstPage.dart';
import 'package:web_auto/page/frontend/home_page.dart';
import 'package:web_auto/page/frontend/login_page.dart';
import 'package:web_auto/page/frontend/news_page.dart';
import 'package:web_auto/page/frontend/product_detail_page.dart';
import 'package:web_auto/page/frontend/product_list.dart';
import 'package:web_auto/utils/MyCustomScrollBehavior.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        initialRoute: '/FirstPage',
        defaultTransition: Transition.native,
        transitionDuration: Duration.zero,
        // Set transition duration to zero
        getPages: [
          GetPage(name: '/FirstPage', page: () => FirstPage()),
          GetPage(name: '/MyHomePage', page: () => MyHomePage()),
          GetPage(name: '/ProductListPage', page: () => ProductListPage()),
          GetPage(name: '/ProductDetailPage', page: () => ProductDetailPage()),
          GetPage(name: '/NewsPage', page: () => NewsPage()),
          GetPage(name: '/CatalogueListPage', page: () => CatalogueListPage()),
          GetPage(
              name: '/CatalogueItemListPage',
              page: () => CatalogueItemListPage()),
          GetPage(name: '/AboutUsPage', page: () => AboutUsPage()),
          GetPage(name: '/ContactUsPage', page: () => ContactUsPage()),
          GetPage(name: '/HomeBackendPage', page: () => HomeBackendPage()),
          GetPage(name: '/NewsBackendPage', page: () => NewsBackendPage()),
          GetPage(
              name: '/ContactUsBackendPage',
              page: () => ContactUsBackendPage()),
          GetPage(
              name: '/AboutUsBackendPage', page: () => AboutUsBackendPage()),
          GetPage(
              name: '/CatalogueBackendPage',
              page: () => CatalogueBackendPage()),
          GetPage(
              name: '/CatalogueImageBackendPage',
              page: () => CatalogueImageBackendPage()),
          GetPage(
              name: '/ProductListBackendPage',
              page: () => ProductListBackendPage()),
          GetPage(
              name: '/ProductImageBackendPage',
              page: () => ProductImageBackendPage()),
          GetPage(name: '/LoginPage', page: () => LoginPage()),
        ],
        builder: EasyLoading.init(),
        title: '鋸開自動化機械有限公司',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ));
  }
}
