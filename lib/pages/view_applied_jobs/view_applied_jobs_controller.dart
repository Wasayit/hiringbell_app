import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/posts.dart';
import 'package:hiringbell/services/http_service.dart';

class ViewAppliedJobsController extends GetxController {
  var isPageReady = false.obs;
  var posts = RxList<Posts>();
  var pageIndex = 0.obs;

  var isLoading = true.obs;
  var hasMore = true.obs;

  var scrollController = ScrollController();

  HttpService http = HttpService.getInstance();

  Future<void> onRefresh() async {
    pageIndex(0);
    isLoading(true);
    hasMore(true);
    posts = RxList<Posts>();
    loadPage();
  }

  Future<void> loadPage() async {
    isPageReady(false);

    try {
      http
          .httpGet("core/userposts/getAppliedJobs/${++pageIndex}")
          .then((value) {
        if (value != null && value.length > 0) {
          List<dynamic> items = value;
          for (var i = 0; i < items.length; i++) {
            posts.add(Posts.fromJson(items[i]));
          }

          isLoading(false);
        } else {
          Fluttertoast.showToast(msg: "No post found");
        }

        isPageReady(true);
      });
    } catch (e) {
      isPageReady(true);
    }
  }

  Future<void> loadNextPage() async {
    isLoading(true);

    try {
      http
          .httpGet("core/userposts/getAppliedJobs/${++pageIndex}")
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
}
