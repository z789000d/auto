import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditImageDialogController extends GetxController {
  late Uint8List bytes;

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.bytes != null) {
      bytes = result.files.single.bytes!;
      Get.back(result: bytes);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}

class EditImageDialog extends StatelessWidget {
  final String? url;

  EditImageDialog({this.url, super.key});

  final EditImageDialogController controller =
      Get.put(EditImageDialogController());


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('輸入內容'),
      content: GestureDetector(
        onTap: () {
          controller.pickImage();
        },
        child: CachedNetworkImage(
          imageUrl: url ?? '',
          width: 120,
          height: 120,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Container(),
        ),
      ),
      actions: <Widget>[
        (url != '')
            ? Container()
            : ElevatedButton(
                onPressed: () {},
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
