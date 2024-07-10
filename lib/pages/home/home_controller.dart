import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/files.dart';
import 'package:hiringbell/models/posts.dart';
import 'package:hiringbell/models/user.dart';
import 'package:hiringbell/pages/home/widgets/image_carousel.dart';
import 'package:hiringbell/services/http_service.dart';
import 'package:hiringbell/utilities/Util.dart';

class HomeController extends GetxController {
  var count = 0.obs;
  var selectedIndex = 0.obs;
  var isHomepageReady = false.obs;
  var posts = RxList<Posts>();
  var pageIndex = 0.obs;
  User user = User();
  bool _isAppliedExecuted = false;

  var isLoading = true.obs;
  var hasMore = true.obs;

  var scrollController = ScrollController();

  HttpService http = HttpService.getInstance();

  void setAppliedExecutedState(bool flag) {
    _isAppliedExecuted = flag;
  }

  bool getAppliedExecutedState() {
    return _isAppliedExecuted;
  }

  incrementValue() {
    count++;
  }

  void onItemTapped(var index) {
    selectedIndex(index);

    switch (index) {
      case 1:
        break;
      case 2:
        break;
      default:
        posts = RxList<Posts>();
        loadHomePage();
        break;
    }
  }

  Future<void> onRefresh() async {
    pageIndex(0);
    isLoading(true);
    hasMore(true);
    posts = RxList<Posts>();
    loadHomePage();
  }

  Future<void> loadHomePage() async {
    isHomepageReady(false);

    try {
      http.httpGet("core/userposts/getHomePage/${++pageIndex}").then((value) {
        if (value != null && value.length > 0) {
          List<dynamic> items = value;
          for (var i = 0; i < items.length; i++) {
            posts.add(Posts.fromJson(items[i]));
          }

          isLoading(false);
        } else {
          Fluttertoast.showToast(msg: "No post found");
        }

        isHomepageReady(true);
      });
    } catch (e) {
      isHomepageReady(true);
    }
  }

  Future<void> loadNextPage() async {
    isLoading(true);

    try {
      http.httpGet("core/userposts/getHomePage/${++pageIndex}").then((value) {
        if (value != null) {
          List<dynamic> items = value;
          if (items.isNotEmpty) {
            for (var i = 0; i < items.length; i++) {
              posts.add(Posts.fromJson(items[i]));
            }
            isLoading(false);
          } else {
            isLoading(false);
            hasMore(false);
          }
        } else {
          Fluttertoast.showToast(msg: "Fail to load the page");
        }
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Fail to load...");
    }
  }

  Future<bool> addLikePost(Posts myPost) async {
    isLoading(true);
    try {
      http
          .httpPost("core/userposts/addLikedPost", myPost.toJson())
          .then((response) {
        if (response!.isSuccess) {
          isLoading(false);
          myPost.isLiked = true;
          return true;
        } else {
          Fluttertoast.showToast(msg: "Fail to like the current post");
          isLoading(false);
          return false;
        }
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Fail to load...");
      isLoading(false);
      return false;
    }
    return false;
  }

  Future<bool> removeLikedPost(Posts myPost) async {
    isLoading(true);
    try {
      http
          .httpDelete(
        "core/userposts/deleteLikedPost/${myPost.userPostId}",
      )
          .then((response) {
        if (response!.isSuccess) {
          isLoading(false);
          myPost.isLiked = false;
          return true;
        } else {
          Fluttertoast.showToast(msg: "Fail to delete liked post");
          isLoading(false);
          return false;
        }
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Fail to load...");
      isLoading(false);
      return false;
    }
    return false;
  }

  String getImageUrl(FileDetail file) {
    return "${http.getImageBaseUrl}${file.filePath}";
  }

  getBackgroundColor(String letter) {
    Color color;
    switch (letter) {
      case 'R':
        color = Colors.red;
        break;
      case 'B':
        color = Colors.blueAccent;
        break;
      case 'I':
        color = Colors.indigoAccent;
        break;
      case 'V':
        color = Colors.purple;
        break;
      default:
        color = Colors.grey;
        break;
    }

    return color;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Util util = Util.getInstance();
    user = util.getUserDetail();
  }
}
