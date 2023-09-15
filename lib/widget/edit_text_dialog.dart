import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditTextDialogController extends GetxController {
  TextEditingController textEditingController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void setText() {}
}

class EditTextDialog extends StatelessWidget {
  final EditTextDialogController controller =
      Get.put(EditTextDialogController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('輸入內容'),
      content: GestureDetector(
        onTap: () {
          controller.setText();
        },
        child: Container(
          width: 300,
          child: EditableText(
            // 使用GlobalKey
            controller: controller.textEditingController,
            backgroundCursorColor: Colors.blue,
            style: TextStyle(fontSize: 16),
            cursorColor: Colors.blue,
            autofocus: true,
            maxLines: null,
            // Allow unlimited lines for auto wrapping
            keyboardType: TextInputType.multiline,
            textAlign: TextAlign.left,
            focusNode: FocusNode(),
          ),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Get.back(result: controller.textEditingController.text);
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
}
