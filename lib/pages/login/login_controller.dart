import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hiringbell/models/navigate.dart';
import 'package:hiringbell/models/user.dart';
import 'package:hiringbell/services/http_service.dart';
import 'package:hiringbell/utilities/Util.dart';

import '../../models/constants.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  Util util = Util.getInstance();
  var isSubmitted = false.obs;
  final isLoading = RxBool(false);
  final http = HttpService.getInstance();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  User user = User();

  Future<void> checkAutoLogin() async {
    Util util = Util.getInstance();
    Auth auth = await util.getAuthDetail();
    if (auth.password.isNotEmpty) {
      debugPrint("Do auto login");
      usernameController.text = auth.email;
      passwordController.text = auth.password;

      onSubmitted();
    } else {
      //usernameController.text = "";
      //passwordController.text = "";
      Util.cleanAll();
    }
  }

  onSubmitted() {
    isSubmitted(true);

    if (formKey.currentState!.validate()) {
      try {
        http.login("oauth/authenticate", {
          "password": passwordController.text,
          "email": usernameController.text.trim(),
          "mobile": null,
        }).then((userData) {
          if (userData == Constants.success) {
            isSubmitted(false);
            Fluttertoast.showToast(msg: "Logged in successfully");
            Get.offAllNamed(Navigate.homeLayout,
                predicate: (route) => Get.currentRoute == Navigate.homeLayout);
          } else {
            Fluttertoast.showToast(
                msg: "Fail to login. Please check your detail.");
            Util.cleanAll();
            isSubmitted(false);
          }
        });
      } catch (e) {
        isSubmitted(false);
      }
    } else {
      isSubmitted(false);
    }
  }

  Future<bool> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // // Create a new credential
    // final credential = firebase_auth.GoogleAuthProvider.credential(
    //   accessToken: googleAuth?.accessToken,
    //   idToken: googleAuth?.idToken,
    // );

    // // Once signed in, return the UserCredential
    // var res = await firebase_auth.FirebaseAuth.instance
    //     .signInWithCredential(credential);

    // print(res.user?.displayName);
    // print(res.user?.email);

    onGoogleSignIn(googleAuth?.accessToken);

    return true;
  }

  onGoogleSignIn(String? accessToken) {
    if (accessToken != null && accessToken.isNotEmpty) {
      try {
        http.login("oauth/googlemobilelogin", {"token": accessToken}).then(
            (userData) {
          if (userData == Constants.success) {
            isSubmitted(false);
            Fluttertoast.showToast(msg: "Logged in successfully");
            Get.offAllNamed(Navigate.homeLayout,
                predicate: (route) => Get.currentRoute == Navigate.homeLayout);
          } else {
            Fluttertoast.showToast(
                msg: "Fail to Google login. Please check your detail.");
            // isSubmitted(false);
          }
        });
      } catch (e) {
        Fluttertoast.showToast(
            msg: "Fail to Google login due to unexpected error occured.");
        // isSubmitted(false);
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
    super.onInit();
    isSubmitted = false.obs;
    user = util.getUserDetail();

    if (!Constants.isProduction) {
      usernameController.text = "istiyaq.4game@gmail.com";
      passwordController.text = "12345678";
    }
  }
}
