import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/create_job/job_post_page.dart';
import 'package:hiringbell/pages/post_new_job/job_post_index.dart';

import '../../models/files.dart';
import '../../models/posts.dart';
import '../../models/user.dart';
import '../../services/http_service.dart';
import '../../utilities/Util.dart';

class PostsController extends GetxController {
  var count = 0.obs;
  var selectedIndex = 0.obs;
  var isHomepageReady = false.obs;
  var posts = RxList<Posts>();
  var pageIndex = 0.obs;
  Util? util;
  User user = User();
  var scrollController = ScrollController();

  var isLoading = true.obs;
  var hasMore = true.obs;

  var controller = ScrollController();

  HttpService http = HttpService.getInstance();

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
    loadHomePage();
  }

  Future<void> loadHomePage() async {
    isHomepageReady(false);

    var user = util?.getUserDetail();
    var userId = user?.userId;
    posts = RxList<Posts>();
    try {
      http.httpGet("core/userposts/getOwnPosts/${++pageIndex}").then((value) {
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
      http
          .httpGet("core/userposts/getOwnPosts/${++pageIndex.value}")
          .then((value) {
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

  ImageProvider<Object> getImage(List<FileDetail> files) {
    ImageProvider<Object> object;
    object = NetworkImage("${http.getImageBaseUrl}${files.first.filePath}");

    return object;
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

  loadJobPostPage() async {
    // var result = await Get.to(const JobPostPage());
    var result = await Get.to(
      const PostNewJobIndex(
        post: null,
      ),
    );
    if (result != null) {
      Fluttertoast.showToast(msg: "Posted successfully");
      onRefresh();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    util = Util.getInstance();
    user = util!.getUserDetail();
  }
}
