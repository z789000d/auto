import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/model/catalogue_model.dart';

import '../../api/catalogue_page_api.dart';
import '../../widget/edit_text_dialog.dart';
import '../../widget/top_bar_backed_widget.dart';
import 'catalogue_image_backend_page.dart';

// 定义控制器类
class CatalogueBackendController extends GetxController {
  // 假设有一个包含数据的 List
  final catalogueResponseModel = CatalogueResponseModel(code: 0, data: []).obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getApi();
  }

  void getApi() {
    CataloguePageApi().postApi(CatalogueRequestModel(action: '0'), (model) {
      catalogueResponseModel.value = model;
    });
  }

  void addData() {
    CataloguePageApi().postApi(
        CatalogueRequestModel(
          action: '1',
          name: '型錄${catalogueResponseModel.value.data.length}',
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3s80ly3CKpK3MJGixmucGYCLfU0am5SteQ&usqp=CAU',
        ), (model) {
      getApi();
    });

    scrollToEnd();
  }

  void deleteData(int index) {
    CataloguePageApi().postApi(
        CatalogueRequestModel(
            action: '3',
            id: catalogueResponseModel.value.data[index].id), (model) {
      getApi();
    });
  }

  void dataUp(int index) {
    if (index > 0) {
      CataloguePageApi().postApi(
          CatalogueRequestModel(
            action: '7',
            id1: catalogueResponseModel.value.data[index].id,
            id2: catalogueResponseModel.value.data[index - 1].id,
          ), (model) {
        getApi();
      });
    }
  }

  void dataDown(int index) {
    if (index < catalogueResponseModel.value.data.length - 1) {
      CataloguePageApi().postApi(
          CatalogueRequestModel(
            action: '7',
            id1: catalogueResponseModel.value.data[index].id,
            id2: catalogueResponseModel.value.data[index + 1].id,
          ), (model) {
        getApi();
      });
    }
  }

  void replaceName(int index) {
    final EditTextDialogController controller =
        Get.put(EditTextDialogController());
    controller.textEditingController.text =
        catalogueResponseModel.value.data[index].name;
    Get.dialog(
      EditTextDialog(),
      barrierDismissible: false,
    ).then((value) {
      if (value == 'Cancel') {
        print('User canceled.');
      } else {
        CataloguePageApi().postApi(
            CatalogueRequestModel(
              action: '5',
              id: catalogueResponseModel.value.data[index].id,
              name: catalogueResponseModel.value.data[index].name,
            ), (model) {
          getApi();
        });
      }
    });
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

class CatalogueBackendPage extends StatelessWidget {
  final CatalogueBackendController controller =
      Get.put(CatalogueBackendController());

  @override
  Widget build(BuildContext context) {
    // 使用GetX来获取控制器实例;
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
                    '電子型錄',
                    style: TextStyle(fontSize: 20),
                  )),
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
              )
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
                      alignment: Alignment.center, child: Text('內容')))),
          DataColumn(
              label: Expanded(
                  child: Container(
                      alignment: Alignment.center, child: Text('功能')))),
        ],
        rows: List<DataRow>.generate(
          controller.catalogueResponseModel.value.data.length,
          (index) => DataRow(
            cells: [
              DataCell(Text('第$index個')),
              DataCell(Text(
                  'ID: ${controller.catalogueResponseModel.value.data[index].id}')),
              DataCell(
                GestureDetector(
                  onTap: () {
                    Get.delete<CatalogueImageBackendController>();

                    final CatalogueImageBackendController
                        catalogueImageBackendController =
                        Get.put(CatalogueImageBackendController());

                    catalogueImageBackendController.cataloguePageResponseModel
                        .value = controller.catalogueResponseModel.value;

                    catalogueImageBackendController.catalogueIndex.value =
                        index;
                    Get.to(CatalogueImageBackendPage());
                  },
                  child: Image.network(
                    controller.catalogueResponseModel.value.data[index]
                        .imageData[0].imageUrl!,
                    width: 120,
                    height: 120,
                  ),
                ),
              ),
              DataCell(GestureDetector(
                onTap: () {
                  controller.replaceName(index);
                },
                child: Text(
                    'text: ${controller.catalogueResponseModel.value.data[index].name}'),
              )),
              DataCell(Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: GestureDetector(
                        onTap: () {
                          controller.dataUp(index);
                        },
                        child: Text('上升')),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: GestureDetector(
                        onTap: () {
                          controller.dataDown(index);
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
