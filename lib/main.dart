import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/page/frontend/about_us.dart';
import 'package:web_auto/page/frontend/catalogue_item_list.dart';
import 'package:web_auto/page/frontend/catalogue_list.dart';
import 'package:web_auto/page/frontend/contact_us.dart';
import 'package:web_auto/page/frontend/firstPage.dart';
import 'package:web_auto/page/frontend/home_page.dart';
import 'package:web_auto/page/frontend/news_page.dart';
import 'package:web_auto/page/frontend/product_detail_page.dart';
import 'package:web_auto/page/frontend/product_list.dart';

class AllMainController extends GetxController {
  final RxDouble nowConstraintsWidth = 0.0.obs;
  final RxDouble nowConstraintsHeight = 0.0.obs;
}

final AllMainController allMainController = Get.put(AllMainController());

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialRoute: '/',
        defaultTransition: Transition.native,
        transitionDuration: Duration.zero,
        // Set transition duration to zero
        getPages: [
          GetPage(name: '/FirstPage', page: () => FirstPage()),
          GetPage(name: '/MyHomePage', page: () => MyHomePage()),
          GetPage(name: '/ProductListPage', page: () => ProductListPage()),
          GetPage(name: '/ProductDetailPage', page: () => ProductDetailPage()),
          GetPage(name: '/NewsPage', page: () => NewsPage()),
          GetPage(name: '/CataloguePage', page: () => CatalogueListPage()),
          GetPage(
              name: '/CatalogueItemListPage',
              page: () => CatalogueItemListPage()),
          GetPage(name: '/AboutUsPage', page: () => AboutUsPage()),
          GetPage(name: '/ContactUsPage', page: () => ContactUsPage()),
        ],
        title: '鋸開自動化機械有限公司',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: FirstPage());
  }
}
