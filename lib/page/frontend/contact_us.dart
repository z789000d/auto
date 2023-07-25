import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_auto/page/frontend/parent_page.dart';
import 'dart:html' as html;

import '../../model/contact_us_model.dart';
import '../../widget/bottom_bar_widget.dart';
import '../../widget/top_bar_widget.dart';

class ContactUsController extends GetxController {
  late GoogleMapController mapController;

  final LatLng center = const LatLng(24.808042175428966, 121.0045145269872);
  final Set<Marker> markers = Set();

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final companyNameController = TextEditingController();
  final companyWebController = TextEditingController();
  final companyCountryController = TextEditingController();
  final companyEmailController = TextEditingController();
  final companyContentController = TextEditingController();

  Rx<ContactUsModel> contactUsModel = ContactUsModel(
          companyText: '',
          locationText: '',
          phoneText: '',
          faxText: '',
          emailText: '')
      .obs;

  @override
  void onInit() {
    super.onInit();

    contactUsModel.value = ContactUsModel(
        companyText: '鋸開自動化有限公司',
        locationText: '新竹市千甲路191號',
        phoneText: '035-723504',
        faxText: '035-745523',
        emailText: 'tinh@ms12.hinet.net');

    markers.add(Marker(
      //add first marker
      markerId: MarkerId("鉅開自動化機械有限公司"),
      position: center, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: '鉅開自動化機械有限公司',
        snippet: '新竹市千甲路191號',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
  }

  @override
  void onClose() {
    companyNameController.dispose(); // Dispose the controller
    super.onClose();
  }

  void sendEmail() {
    if (companyNameController.value.text == "") {
      showDialog('請輸入公司名稱');
      return;
    }
    if (companyCountryController.value.text == "") {
      showDialog('請輸入國家');
      return;
    }
    if (companyEmailController.value.text == "") {
      showDialog('請輸入email');
      return;
    }
    if (companyContentController.value.text == "") {
      showDialog('請輸入內容');
      return;
    }

    showDialog('送出成功');
    clearEdit();
  }

  void clearEdit() {
    companyNameController.text = "";
    companyWebController.text = "";
    companyCountryController.text = "";
    companyEmailController.text = "";
    companyContentController.text = "";
  }

  void showDialog(String text) {
    Get.dialog(
      AlertDialog(
        title: Text(''),
        content: Text(text),
        actions: [
          TextButton(
            child: Text("Close"),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }
}

class ContactUsPage extends ParentPage {
  final ContactUsController controller = Get.put(ContactUsController());

  ContactUsPage({super.key});

  @override
  Widget childWidget() {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              '聯絡我們',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
                color: Colors.blue,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 30),
            color: Colors.blue,
            width: Get.width / 1.5,
            height: Get.height / 1.5,
            child: GoogleMap(
              onMapCreated: controller.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: controller.center,
                zoom: 15.0,
              ),
              markers: controller.markers,
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            width: Get.width,
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.contactUsModel.value.companyText,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 30.0),
                Text(
                  '公司地址:${controller.contactUsModel.value.locationText}',
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 8.0),
                Text(
                  '電話:${controller.contactUsModel.value.phoneText}',
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 8.0),
                Text(
                  '傳真:${controller.contactUsModel.value.faxText}',
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 8.0),
                Text(
                  '電子郵件:${controller.contactUsModel.value.emailText}',
                  textAlign: TextAlign.start,
                ),
                inputEdit()
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget inputEdit() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
        ),
        borderRadius: BorderRadius.circular(5), // 添加圆角
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            width: 300,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  child: Text(
                    '*',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Container(
                  width: 80,
                  child: Text(
                    '公司名稱:',
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: TextField(
                      controller: controller.companyNameController,
                      style: TextStyle(fontSize: 12.0),
                      decoration: InputDecoration(
                        hintText: '輸入公司名稱',
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
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 300,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  child: Text(
                    ' ',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Container(
                  width: 80,
                  child: Text(
                    '公司網站:',
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, top: 10),
                    child: TextField(
                      controller: controller.companyWebController,
                      style: TextStyle(fontSize: 12.0),
                      decoration: InputDecoration(
                        hintText: '輸入公司網站',
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
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 300,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  child: Text(
                    '*',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Container(
                  width: 80,
                  child: Text(
                    '國家:',
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, top: 10),
                    child: TextField(
                      controller: controller.companyCountryController,
                      style: TextStyle(fontSize: 12.0),
                      decoration: InputDecoration(
                        hintText: '輸入公司網站',
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
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 300,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  child: Text(
                    '*',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Container(
                  width: 80,
                  child: Text(
                    'email:',
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, top: 10),
                    child: TextField(
                      controller: controller.companyEmailController,
                      style: TextStyle(fontSize: 12.0),
                      decoration: InputDecoration(
                        hintText: '輸入email',
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
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 300,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  child: Text(
                    '*',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Container(
                  width: 80,
                  child: Text(
                    '內容:',
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, top: 10),
                    child: TextField(
                      controller: controller.companyContentController,
                      style: TextStyle(fontSize: 12.0),
                      decoration: InputDecoration(
                        hintText: '輸入內容',
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
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  controller.clearEdit();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  width: 80,
                  child: Text(
                    '清除',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.sendEmail();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20, left: 20),
                  width: 80,
                  child: Text(
                    '送出',
                    textAlign: TextAlign.center,
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
