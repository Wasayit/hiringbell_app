import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/api_response.dart';
import 'package:hiringbell/models/post_job.dart';
import 'package:hiringbell/services/http_service.dart';
import 'package:hiringbell/utilities/Util.dart';

import '../../models/constants.dart';

class ViewPostController extends GetxController {
  int postId = Get.arguments as int;
  HttpService http = HttpService.getInstance();
  Util util = Util.getInstance();
  JobPost? postsDetail;
  bool jobStatus = false;
  var jobStatusTrigger = false.obs;
  var jobSavedStatusTrigger = false.obs;

  var isLoading = true.obs;
  var isApplying = false.obs;
  var isJobSaving = false.obs;

  Future<void> onRefresh() async {}

  String getTitleSubDesc() {
    String result = "";
    var days = DateTime.now().difference(postsDetail!.postedOn!).inDays;
    result = "$days days old post. ";
    if (postsDetail!.isForeignReturnCompulsory != null &&
        postsDetail!.isForeignReturnCompulsory!) {
      result += "(Only foreign return)";
    }

    return result;
  }

  Future<void> applyForJob() async {
    isApplying(true);

    ApiResponse? response =
        await http.httpPost("core/userposts/addAppliedPost", {
      "userPostId": postsDetail!.userPostId,
    });

    if (response != null && response.responseBody == "success") {
      postsDetail!.jobAppliedOn = DateTime.now();
      util.showToast("Job applied successfully");
      jobStatus = true;
      jobStatusTrigger.value = true;
      isApplying(false);
    } else {
      util.showToast("Got some error. Fail to apply", type: Constants.fail);
      isApplying(false);
    }
  }

  Future<void> saveForJob() async {
    isJobSaving(true);

    ApiResponse? response = await http.httpPost("core/userposts/addSavedPost", {
      "userPostId": postsDetail!.userPostId,
    });

    if (response != null && response.responseBody == "success") {
      postsDetail!.jobSavedOn = DateTime.now();
      util.showToast("Job saved successfully");
      // jobStatus = true;
      jobSavedStatusTrigger.value = true;
      isJobSaving(false);
    } else {
      util.showToast("Got some error. Fail to apply", type: Constants.fail);
      isJobSaving(false);
    }
  }

  Future<void> loadPostDetail() async {
    var response = await http.httpGet("core/userposts/getPostByPostId/$postId");

    if (response != null) {
      postsDetail = JobPost.fromJson(response);
      var userDetail = util.getUserDetail();
      if (postsDetail!.jobAppliedOn != null ||
          postsDetail!.postedBy == userDetail.userId) {
        jobStatusTrigger.value = true;
      }

      if (postsDetail!.jobSavedOn != null) {
        jobSavedStatusTrigger.value = true;
      }

      debugPrint(
          'job posted on: ${postsDetail!.jobAppliedOn} for short Desc: ${postsDetail?.shortDescription}');

      isLoading(false);
    } else {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
