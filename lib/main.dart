import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/page/about_us.dart';
import 'package:web_auto/page/catalogue_list.dart';
import 'package:web_auto/page/contact_us.dart';
import 'package:web_auto/page/firstPage.dart';
import 'package:web_auto/page/home_page.dart';
import 'package:web_auto/page/product_detail_page.dart';
import 'package:web_auto/page/product_list.dart';

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
        getPages: [
          GetPage(name: '/FirstPage', page: () => FirstPage()),
          GetPage(name: '/MyHomePage', page: () => MyHomePage()),
          GetPage(name: '/ProductListPage', page: () => ProductListPage()),
          GetPage(name: '/ProductDetailPage', page: () => ProductDetailPage()),
          GetPage(name: '/CataloguePage', page: () => CatalogueListPage()),
          GetPage(name: '/AboutUsPage', page: () => AboutUsPage()),
          GetPage(name: '/ContactUsPage', page: () => ContactUsPage()),
        ],
        title: '鋸開自動化機械有限公司',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FirstPage());
  }
}
