import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/navigate.dart';
import 'package:hiringbell/models/user.dart';
import 'package:hiringbell/services/http_service.dart';
import 'package:hiringbell/utilities/Util.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  var isSubmitted = false.obs;
  final isLoading = RxBool(false);
  final http = HttpService.getInstance();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  User user = User();

  onSubmitted() {
    isSubmitted(true);

    if (formKey.currentState!.validate()) {
      try {
        http.login("oauth/authenticate", {
          "Password": passwordController.text,
          "Email": usernameController.text,
          "Mobile": null
        }).then((userData) {
          if (userData == "success") {
            isSubmitted(false);
            Fluttertoast.showToast(msg: "Logged in successfully");
            Get.offAllNamed(Navigate.homeLayout,
                predicate: (route) => Get.currentRoute == Navigate.homeLayout);
            debugPrint("Success");
          } else {
            Fluttertoast.showToast(
                msg: "Fail to login. Please check your detail.");
            debugPrint("Fail");
            isSubmitted(false);
          }
        });
      } catch (e) {
        isSubmitted(false);
      }
    }
  }

  validateUserName(String? username) {
    if (username == null || username.isEmpty) {
      return "Invalid username";
    }

    return null;
  }

  validatePassword(String? username) {
    if (username == null || username.isEmpty) {
      return "Invalid password";
    }

    return null;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isSubmitted = false.obs;
    Util util = Util.getInstance();
    user = util.getUserDetail();

    usernameController.text = "istiyaq.4game@gmail.com";
    passwordController.text = "Hiring_Bell@bot@9100@bottomHalf";
  }
}
