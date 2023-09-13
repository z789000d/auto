import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils.dart';

class EditCategoryDialogController extends GetxController {
  final categoryList = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void setText() {}
}

class EditCategoryDialog extends StatelessWidget {
  final EditCategoryDialogController controller =
  Get.put(EditCategoryDialogController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('輸入內容'),
      content: GestureDetector(
          child: Container(
            width: 500,
            child: Column(
              children: [
                Obx(() => Text(controller.categoryList.value)),
                categoryWidget(),
              ],
            ),
          )),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Get.back(result: controller.categoryList.value);
          },
          child: Text('Confirm'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back(result: 'Cancel'); // Return 'Cancel' as the result
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }

  Widget categoryWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          margin: EdgeInsets.only(left: 40, top: 10, bottom: 10, right: 40),
          child: Row(
            children: [
              Container(
                width: 400,
                alignment: Alignment.center,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 8,
                      childAspectRatio: 2),
                  itemCount: Utils.category.length,
                  itemBuilder: (BuildContext context, int index) {
                    return categoryItemWidget(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget categoryItemWidget(index) {
    return Obx(
          () =>
          GestureDetector(
            onTap: () {
              var categoryList = controller.categoryList.value == ''
                  ? []
                  : controller.categoryList.value.split(',');
              if (categoryList.contains(Utils.category[index])) {
                categoryList.remove(Utils.category[index]);
                controller.categoryList.value = categoryList
                    .toString()
                    .replaceAll('[', '')
                    .replaceAll(']', '')
                    .replaceAll(' ', '');
              } else {
                categoryList.add(Utils.category[index]);
                controller.categoryList.value = categoryList
                    .toString()
                    .replaceAll('[', '')
                    .replaceAll(']', '')
                    .replaceAll(' ', '');
              }
              print(categoryList);
            },
            child: Container(
              decoration: BoxDecoration(
                color: controller.categoryList.value
                    .split(',')
                    .contains(Utils.category[index])
                    ? Colors.blue
                    : Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.black, // 边框颜色
                  width: 1, // 边框宽度
                ),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                Utils.category[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: controller.categoryList.value
                      .split(',')
                      .contains(Utils.category[index])
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
    );
  }
}
