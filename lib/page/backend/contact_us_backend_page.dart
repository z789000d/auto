import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/model/contact_us_model.dart';
import 'package:web_auto/widget/bottom_bar_widget.dart';
import 'package:web_auto/widget/top_bar_widget.dart';

import '../../api/contact_us_page_api.dart';
import '../../widget/top_bar_backed_widget.dart';

// 定义控制器类
class ContactUsBackendController extends GetxController {
  final companyContentController = TextEditingController().obs;
  final locationContentController = TextEditingController().obs;
  final phoneContentController = TextEditingController().obs;
  final faxContentController = TextEditingController().obs;
  final emailContentController = TextEditingController().obs;
  Rx<ContactUsResponseModel> contactUsModel = ContactUsResponseModel(
          code: 0,
          contactUsData: ContactUsData(
              companyText: '',
              locationText: '',
              phoneText: '',
              faxText: '',
              emailText: ''))
      .obs;

  @override
  void onInit() {
    super.onInit();
    // 初始化数据
    getContactUsApi();
  }

  void getContactUsApi() {
    ContactUsPageApi().postApi(ContactUsRequestModel(action: 0), (model) {
      contactUsModel.value = model;
      companyContentController.value.text =
          contactUsModel.value.contactUsData.companyText!;
      locationContentController.value.text =
          contactUsModel.value.contactUsData.locationText!;
      phoneContentController.value.text =
          contactUsModel.value.contactUsData.phoneText!;
      faxContentController.value.text =
          contactUsModel.value.contactUsData.faxText!;
      emailContentController.value.text =
          contactUsModel.value.contactUsData.emailText!;
    });
  }

  void replaceData() {
    ContactUsPageApi().postApi(
        ContactUsRequestModel(
            action: 2,
            companyText: companyContentController.value.text,
            locationText: locationContentController.value.text,
            phoneText: phoneContentController.value.text,
            faxText: faxContentController.value.text,
            emailText: emailContentController.value.text), (model) {
      getContactUsApi();
    });
  }
}

class ContactUsBackendPage extends StatelessWidget {
  final ContactUsBackendController controller =
      Get.put(ContactUsBackendController());

  @override
  Widget build(BuildContext context) {
    // 使用GetX来获取控制器实例

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBarBacked(),
          Container(
              margin: EdgeInsets.all(10),
              child: Text(
                '聯絡我們',
                style: TextStyle(fontSize: 20),
              )),
          Container(margin: EdgeInsets.all(10), child: table()),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // 设置边框颜色
                width: 1, // 设置边框宽度
              ),
            ),
            child: GestureDetector(
                onTap: () {
                  controller.replaceData();
                },
                child: Text('修改')),
          )
        ],
      )),
    );
  }

  Widget table() {
    return Obx(
      () => Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                width: 80,
                child: Text(
                  '公司名稱:',
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    maxLines: 1,
                    controller: controller.companyContentController.value,
                    style: TextStyle(fontSize: 12.0),
                    decoration: InputDecoration(
                      hintText: '輸入公司名稱',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(width: 1.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                width: 80,
                child: Text(
                  '公司地址:',
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    maxLines: 1,
                    controller: controller.locationContentController.value,
                    style: TextStyle(fontSize: 12.0),
                    decoration: InputDecoration(
                      hintText: '輸入公司地址',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(width: 1.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                width: 80,
                child: Text(
                  '公司電話:',
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    maxLines: 1,
                    controller: controller.phoneContentController.value,
                    style: TextStyle(fontSize: 12.0),
                    decoration: InputDecoration(
                      hintText: '輸入公司電話',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(width: 1.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                width: 80,
                child: Text(
                  '公司傳真:',
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    maxLines: 1,
                    controller: controller.faxContentController.value,
                    style: TextStyle(fontSize: 12.0),
                    decoration: InputDecoration(
                      hintText: '輸入公司傳真',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(width: 1.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                width: 80,
                child: Text(
                  '電子郵件:',
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    maxLines: 1,
                    controller: controller.emailContentController.value,
                    style: TextStyle(fontSize: 12.0),
                    decoration: InputDecoration(
                      hintText: '輸入電子郵件',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(width: 1.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
