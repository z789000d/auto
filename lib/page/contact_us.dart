import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:web_auto/widget/top_bar_widget.dart';
import '../main.dart';
import '../widget/bottom_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

class ContactUsController extends GetxController {
  final RxDouble nowConstraintsWidth = 0.0.obs;
  final RxDouble nowConstraintsHeight = 0.0.obs;

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

  @override
  void onInit() {
    super.onInit();

    markers.add(Marker(
      //add first marker
      markerId: MarkerId("鋸開自動化機械"),
      position: center, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: '鋸開自動化機械',
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
}

class ContactUsPage extends StatelessWidget {
  final ContactUsController controller = Get.put(ContactUsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          controller.nowConstraintsWidth.value = constraints.maxWidth;
          controller.nowConstraintsHeight.value = constraints.maxHeight;
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TopBar(),
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
                        margin: EdgeInsets.only(
                            left: 10, right: 10, bottom: 10, top: 30),
                        color: Colors.blue,
                        width: Get.height / 2,
                        height: Get.height / 2,
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
                              '鋸開自動化有限公司',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.normal,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              '公司地址:新竹市千甲路191號',
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '電話:035-723504',
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '傳真:035-745523',
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '電子郵件:tinh@ms12.hinet.net',
                              textAlign: TextAlign.start,
                            ),
                            inputEdit()
                          ],
                        ),
                      ),
                      BottomWidget(),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget inputEdit() {
    return Column(
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
        ),
        Container(
          alignment: Alignment.center,
          width: 300,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
        ),
        Container(
          alignment: Alignment.center,
          width: 300,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
        ),
        Container(
          alignment: Alignment.center,
          width: 300,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
        ),
        Container(
          alignment: Alignment.center,
          width: 300,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 80,
            child: Text(
              '送出',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
