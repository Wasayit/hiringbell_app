import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/models/user.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../models/auth.dart';
import '../services/http_service.dart';

class Util {
  static SharedPreferences? _prefs;
  static Util? _util;
  var http = HttpService.getInstance();

  static Future<void> init(SharedPreferences sharedPreferences) async {
    // ignore: unnecessary_null_comparison
    if (sharedPreferences == null) {
      throw Exception("Invalid Shred Preference object found");
    }

    _prefs = sharedPreferences;
  }

  static DateTime? toDateTime(String? date) {
    if (date != null && date != "") {
      return Jiffy.parse(date).dateTime;
    } else {
      return null;
    }
  }

  static SharedPreferences getSharedPreferences() {
    return _prefs!;
  }

  Future setUpSharedPreferences() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Util getInstance() {
    if (_util == null) {
      _util = Util._internal();
      _util!.setUpSharedPreferences();
    }

    return _util!;
  }

  static DateTime convertToDateTime(String? date) {
    if (date != null && date != "") {
      return Jiffy.parse(date).dateTime;
    } else {
      return DateTime.now();
    }
  }

  void setUserDetail(dynamic user) {
    String result = jsonEncode(user);
    _prefs!.setString(Constants.userDetail, result);
  }

  static void cleanAll() {
    for (String key in _prefs!.getKeys()) {
      debugPrint("Key deleting: $key");
      _prefs!.remove(key);
    }
  }

  User getUserDetail() {
    try {
      var user = _prefs!.get(Constants.userDetail) as String;
      dynamic result = jsonDecode(user);
      return User.fromJson(result);
    } catch (e) {
      return User();
    }
  }

  void setAuthDetail(dynamic user) {
    String result = jsonEncode(user);
    _prefs!.setString(Constants.auth, result);
  }

  static bool cleanAuth() {
    bool flag = false;
    if (_prefs!.containsKey(Constants.auth)) {
      _prefs!.remove(Constants.auth);
      flag = true;
    }

    return flag;
  }

  Future<Auth> getAuthDetail() async {
    try {
      _prefs ??= await setUpSharedPreferences();
      var authenticationDetail = _prefs!.get(Constants.auth) as String;
      dynamic result = jsonDecode(authenticationDetail);
      return Auth.fromJson(result);
    } catch (e) {
      return Auth(
          email: Constants.empty,
          password: Constants.empty,
          mobile: Constants.empty);
    }
  }

  ImageProvider<Object> getImageProvider(String imageUrl) {
    Image image = getImage(imageUrl);
    return image.image;
  }

  Widget getImageWidget(String imageUrl) {
    return getImage(imageUrl);
  }

  void showToast(String message, {String type = Constants.success}) {
    Color color;
    Color textColor;
    switch (type) {
      case Constants.fail:
        color = Colors.red;
        textColor = Colors.white;
        break;
      case Constants.warning:
        color = Colors.yellow;
        textColor = Colors.black;
        break;
      default:
        color = Colors.green;
        textColor = Colors.white;
        break;
    }

    // Get.snackbar(
    //   type,
    //   message,
    //   snackPosition: SnackPosition.BOTTOM,
    //   backgroundColor: color,
    //   colorText: textColor,
    //   maxWidth: 350,
    //   margin: const EdgeInsets.only(
    //     bottom: 10,
    //   ),
    // );

    Fluttertoast.showToast(
        timeInSecForIosWeb: 3,
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: color,
        textColor: textColor);
  }

  String? getImagePath(String? relativePath) {
    String? absolutePath;
    if (relativePath != null && relativePath.isNotEmpty) {
      absolutePath = "${http.getImageBaseUrl}$relativePath";
    }
    return absolutePath;
  }

  static List<int> genSequence(int from, int to) {
    if (from > to) {
      throw ArgumentError('From cannot be greater than to.');
    }
    return List<int>.generate(to - from + 1, (i) => from + i);
  }

  void removeCachedImage(String? imageUrl) {
    var url = getImagePath(imageUrl);
    if (url == null) return;
    CachedNetworkImage.evictFromCache(url);
  }

  Widget getCachedImageFromUrl(String? imageUrl) {
    return getCachedImage(getImagePath(imageUrl));
  }

  Widget getCachedImage(String? imageUrl) {
    try {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        placeholder: (context, url) => Center(
          // child: CircularProgressIndicator(
          //   color: Colors.red,
          // ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white),
          ),
        ),
        imageBuilder: (context, imageProvider) => Container(
          width: MediaQuery.of(context).size.width,
          // height: 250.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        errorWidget: (context, url, error) => errorImageWidget(),
      );
    } catch (e) {
      return errorImageWidget();
    }
  }

  Image errorImageWidget() {
    return Image.asset("assets/user.png");
  }

  Image getImage(String? imageUrl) {
    Image image;
    if (imageUrl == null || imageUrl == "") {
      return errorImageWidget();
    }

    try {
      image = Image.network(
        imageUrl,
        fit: BoxFit.fill,
        errorBuilder: (context, _, stack) {
          return errorImageWidget();
        },
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      );
    } catch (e) {
      image = errorImageWidget();
      debugPrint('Fail to load image');
    }

    return image;
  }

  static TextStyle getLabelHeaderStyle() {
    return const TextStyle(
      fontSize: Constants.fontSize * 1.2,
      fontWeight: FontWeight.w500,
    );
  }

  static EdgeInsets getPagePadding() {
    return const EdgeInsets.symmetric(
      horizontal: Constants.pagePadding,
      vertical: Constants.pagePadding,
    );
  }

  static InputDecoration getTextFieldDecoration({ required String placeholder, Widget? leadingIcon, Widget? trailingIcon }) {
    return InputDecoration(
      prefixIcon: leadingIcon,
      suffixIcon: trailingIcon,
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey.shade400,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey.shade400,
        ), // Change the color to your desired color
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey.shade400,
        ), // Change the color to your desired color
      ),
      labelText: placeholder,
      labelStyle: const TextStyle(
        color: Colors.grey,
      ), // Change label text color
    );
  }

  static delayScreen(int sec) async {
    await Future.delayed(
      Duration(seconds: sec),
      () {},
    );
  }

  Util._internal();
}
