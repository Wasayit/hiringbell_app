import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/dropdown_items.dart';
import 'package:hiringbell/models/navigate.dart';
import 'package:hiringbell/services/http_service.dart';
import 'package:hiringbell/utilities/Util.dart';

import '../../models/constants.dart';

class ShortRegistrationController extends GetxController {
  final formKey = GlobalKey<FormState>();

  Util util = Util.getInstance();
  var isSubmitted = false.obs;
  final isLoading = RxBool(false);
  final http = HttpService.getInstance();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  var gender = "";

  List<DropdownItems<String>> listGender = [
    DropdownItems(text: 'Male', value: 'm'),
    DropdownItems(text: 'Female', value: 'f'),
    DropdownItems(text: 'Other', value: 'o'),
  ];

  onSubmit() {
    isSubmitted(true);

    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      http.login("oauth/shortsignup", {
        "password": passwordController.text,
        "fullName": usernameController.text.trim(),
        "email": emailController.text.trim(),
        "gender": gender,
      }).then((userData) {
        if (userData == Constants.success) {
          isSubmitted(false);
          Fluttertoast.showToast(msg: "Registered successfully");
          Get.offAllNamed(Navigate.homeLayout,
              predicate: (route) => Get.currentRoute == Navigate.homeLayout);
        } else {
          Fluttertoast.showToast(
              msg: "Fail to Register. Please check your detail.");
          Util.cleanAll();
          isSubmitted(false);
        }
      });
    } catch (e) {
      isSubmitted(false);
    }
  }
}
