import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_auto/utils.dart';

class LoginController extends GetxController {
  RxString username = ''.obs;
  RxString password = ''.obs;
  RxBool isLoggedIn = false.obs;

  void onUsernameChanged(String value) {
    username.value = value;
  }

  void onPasswordChanged(String value) {
    password.value = value;
  }

  void login() {
    // 在這裡處理登入邏輯，這裡只是示例，你可以根據實際情況進行處理
    if (username.value == 'admin' && password.value == 'password') {
      Get.dialog(
        AlertDialog(
          title: Text('登入成功'),
          actions: [
            TextButton(
              onPressed: () {
                // 在這裡處理按下對話框的操作
                Get.back(); // 關閉對話框
                isLoggedIn.value = true; // 登入成功，將 isLoggedIn 設置為 true
                Utils.clickButton(0);
              },
              child: Text('確定'),
            ),
          ],
        ),
      );
    } else {
      AlertDialog(
        title: Text('登入失敗 請檢查帳號密碼是否正確！'),
        actions: [
          TextButton(
            onPressed: () {
              // 在這裡處理按下對話框的操作
              Get.back(); // 關閉對話框
            },
            child: Text('確定'),
          ),
        ],
      );
    }
  }
}

class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登入畫面'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                onChanged: loginController.onUsernameChanged,
                decoration: InputDecoration(
                  labelText: '帳號',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: loginController.onPasswordChanged,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '密碼',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: loginController.login,
                child: Text('登入'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
