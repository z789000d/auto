import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/widget/bottom_bar_widget.dart';
import 'package:web_auto/widget/top_bar_widget.dart';

import '../../widget/top_bar_backed_widget.dart';

// 定义控制器类
class AboutUsBackendController extends GetxController {
  // 假设有一个包含数据的 List
  RxList<Map<String, dynamic>> data = <Map<String, dynamic>>[].obs;
  final companyContentController = TextEditingController().obs;
  final ScrollController scrollController = ScrollController();

  RxString text = RxString(
      "鉅開公司創立於1993年專業製造、開發、設計自動化生產機械，範圍含括航太、汽車、電子、五金制品、娛樂、飲食等各行業生產器具。\n\n" +
          "公司位於臺灣科技工業區新竹，不僅擁有豐厚的科技資源做為後盾，更能隨時掌握世界脈動的訊息知識來構建您所需的一流產品。\n\n" +
          "我們秉持奉行『以人為本，科技興業，品質第一，服務至上，不斷創新』，提供最人性化、最經濟效益、最高品質服務的信念生產。責任意識、創業精神、誠信和優質服務更是我公司企業文化的精髓。\n\n" +
          "鉅開公司以不斷創新和提供優質服務，並持續專精技術、引進精密加工設備、人文管理科學的方式，期與顧客永恆發展為主要的經營理念。滿足顧客要求創建最好的產品品質方針，是我公司至今仍保有廣大客戶群的最高指導原則。\n\n" +
          "合作廠家遍及歐美、中東、中國大陸、臺灣、韓國、日本及東南亞地區，產品深獲信賴好評。\n\n");

  @override
  void onInit() {
    super.onInit();
    // 初始化数据
    for (int i = 0; i < 10; i++) {
      data.add({
        'id': i,
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
        'function': 'Function $i'
      });
    }

    companyContentController.value.text =
        ("鉅開公司創立於1993年專業製造、開發、設計自動化生產機械，範圍含括航太、汽車、電子、五金制品、娛樂、飲食等各行業生產器具。\n\n" +
            "公司位於臺灣科技工業區新竹，不僅擁有豐厚的科技資源做為後盾，更能隨時掌握世界脈動的訊息知識來構建您所需的一流產品。\n\n" +
            "我們秉持奉行『以人為本，科技興業，品質第一，服務至上，不斷創新』，提供最人性化、最經濟效益、最高品質服務的信念生產。責任意識、創業精神、誠信和優質服務更是我公司企業文化的精髓。\n\n" +
            "鉅開公司以不斷創新和提供優質服務，並持續專精技術、引進精密加工設備、人文管理科學的方式，期與顧客永恆發展為主要的經營理念。滿足顧客要求創建最好的產品品質方針，是我公司至今仍保有廣大客戶群的最高指導原則。\n\n" +
            "合作廠家遍及歐美、中東、中國大陸、臺灣、韓國、日本及東南亞地區，產品深獲信賴好評。\n\n");
  }

  void addData() {
    data.add({
      'id': data.length,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
      'function': 'Function ${data.length}'
    });
    scrollToEnd();
  }

  void deleteData(int index) {
    data.removeAt(index);
  }

  void scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    });
  }
}

class AboutUsBackendPage extends StatelessWidget {
  final AboutUsBackendController controller =
      Get.put(AboutUsBackendController());

  @override
  Widget build(BuildContext context) {
    // 使用GetX来获取控制器实例

    return Scaffold(
      body: SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBarBacked(),
              Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    '關於我們',
                    style: TextStyle(fontSize: 20),
                  )),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    width: 80,
                    child: Text(
                      '介紹:',
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: TextField(
                        maxLines: 10,
                        controller: controller.companyContentController.value,
                        style: TextStyle(fontSize: 12.0),
                        decoration: InputDecoration(
                          hintText: '輸入介紹',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(width: 1.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // 设置边框颜色
                        width: 1, // 设置边框宽度
                      ),
                    ),
                    child: Text('修改'),
                  ),
                ],
              ),
              Container(margin: EdgeInsets.all(10), child: table()),
              Container(
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // 设置边框颜色
                    width: 1, // 设置边框宽度
                  ),
                ),
                child: GestureDetector(
                    onTap: () {
                      controller.addData();
                    },
                    child: Text('新增')),
              ),
            ],
          )),
    );
  }

  Widget table() {
    return Obx(
      () => DataTable(
        dividerThickness: 1,
        // 设置分隔线的厚度
        dataRowMinHeight: 100,
        dataRowMaxHeight: 150,
        columns: [
          DataColumn(
              label: Expanded(
                  child: Container(
                      alignment: Alignment.center, child: Text('排序')))),
          DataColumn(
              label: Expanded(
                  child: Container(
                      alignment: Alignment.center, child: Text('id')))),
          DataColumn(
              label: Expanded(
                  child: Container(
                      alignment: Alignment.center, child: Text('圖片')))),
          DataColumn(
              label: Expanded(
                  child: Container(
                      alignment: Alignment.center, child: Text('功能')))),
        ],
        rows: List<DataRow>.generate(
          controller.data.length,
          (index) => DataRow(
            cells: [
              DataCell(Text('第$index個')),
              DataCell(Text('ID: ${controller.data[index]['id']}')),
              DataCell(
                Image.network(
                  controller.data[index]['image'],
                  width: 120,
                  height: 120,
                ),
              ),
              DataCell(Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: GestureDetector(
                        onTap: () {
                          if (index > 0) {
                            controller.data.insert(
                                index - 1, controller.data.removeAt(index));
                          }
                        },
                        child: Text('上升')),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: GestureDetector(
                        onTap: () {
                          if (index < controller.data.length - 1) {
                            controller.data.insert(
                                index + 1, controller.data.removeAt(index));
                          }
                        },
                        child: Text('下降')),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20), child: Text('修改')),
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: GestureDetector(
                          onTap: () {
                            controller.deleteData(index);
                          },
                          child: Text('刪除'))),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
