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
                        margin: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 30),
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
                            )
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
}
