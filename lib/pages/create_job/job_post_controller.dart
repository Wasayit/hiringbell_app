import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/models/country.dart';
import 'package:hiringbell/models/currency.dart';
import 'package:hiringbell/models/dropdown_items.dart';
import 'package:hiringbell/models/files.dart';
import 'package:hiringbell/models/job_type.dart';
import 'package:hiringbell/models/post_job.dart';
import 'package:hiringbell/models/posts.dart';
import 'package:hiringbell/pages/common/bt_select/form_util.dart';
import 'package:hiringbell/utilities/Util.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/http_service.dart';

class JobPostController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var isSubmitted = false.obs;
  final isLoading = RxBool(false);
  final http = HttpService.getInstance();
  final jobTitle = TextEditingController();
  final jobDescription = TextEditingController();
  // final jobMinimumCTC = TextEditingController();
  // final jobMaximumCTC = TextEditingController();
  // final jobBonus = TextEditingController();
  // final jobSpecialAllowances = TextEditingController();
  // final jobHRA = TextEditingController();
  // final jobTRA = TextEditingController();
  // final jobFoodAllowances = TextEditingController();

  // final jobDailyWorkingHours = TextEditingController();
  // final jobOverseasExperience = TextEditingController();
  final util = Util.getInstance();
  List<XFile> selectedFiles = [];

  var serverImages = RxList<FileDetail>([]).obs;
  var pickedImages = RxList<XFile>([]).obs;
  var isImagePicked = true.obs;
  var isFileReady = false.obs;
  var overtimeFlag = false.obs;
  List<FileDetail> deletedFiles = [];

  var openFlags = [false, false, false].obs;
  var experienceFlag = false.obs;

  List<JobType> listJobType = [];
  List<Currency> listCurrency = [];
  List<Country> listCountry = [];

  List<DropdownItems> listMedicalInsurance = [
    DropdownItems(text: 'By company', value: 1),
    DropdownItems(text: 'No insurance', value: 2),
  ];

  List<DropdownItems> listVisaType = [
    DropdownItems(text: 'Tourist', value: 1),
    DropdownItems(text: 'Employment', value: 2),
  ];

  List<int> listMinAge = Util.genSequence(18, 45);
  List<int> listMaxAge = Util.genSequence(18, 45);
  List<int> listOverTime = Util.genSequence(0, 10);
  List<int> listDailyWorkingHours = Util.genSequence(1, 12);
  List<int> listExperience = Util.genSequence(0, 25);
  List<int> listMonths = Util.genSequence(0, 12);

  JobPost jobPost = JobPost.noArg();
  int? jobPostId_;

  JobPostController({this.jobPostId_});

  int get overseasExperienceYears => jobPost.overseasExperience ~/ 12;
  int get overseasExperienceMonths => jobPost.overseasExperience % 12;

  int get localExperienceYears => jobPost.localExperience ~/ 12;
  int get localExperienceMonths => jobPost.localExperience % 12;

  Future<void> onInitRefresh() async {
    jobPostId_ ??= 0;
    FormUtil.isEdit = (jobPostId_! > 0);
    try {
      isLoading(true);
      await loadFormData(jobPostId_!);
    } finally {
      isLoading(false);
    }
  }

  // assignExistingPost(Posts? post) {
  //   // post.userPostId
  //   // update();
  //   loadFormData(post?.userPostId ?? 0);
  // }

  refreshEditValues(JobPost post) {
    // jobPost.shortDescription = post.job
    // jobTitle.text = post.shortDescription ?? Constants.empty;
    // jobDescription.text = post.completeDescription ?? Constants.empty;
    // jobMinimumCTC.text = post.minimumCTC.toString();
    // jobMaximumCTC.text = post.maximumCTC.toString();
    // jobBonus.text = post.bonus.toString();
    // // jobSpecialAllowances.text = post..toString();
    // jobHRA.text = post.hraAllowanceAmount.toString();
    // jobTRA.text = post.travelAllowanceAmount.toString();
    // jobFoodAllowances.text = post.foodAllowanceAmount.toString();
    //wasay
  }

  updateIsSubmitted(bool flag) {
    isSubmitted.value = flag;
  }

  updateAllowanceExpansion(int index, bool isOpen) {
    openFlags[index] = isOpen;
  }

  updateExperienceFlag(int index, bool isOpen) {
    experienceFlag.value = isOpen;
  }

  updateOvertimeFlag(int index, bool isOpen) {
    overtimeFlag.value = isOpen;
  }

  getWeekdaysStatus(int i) {
    switch (i) {
      case 1:
        return jobPost.isMon ?? false;
      case 2:
        return jobPost.isTue ?? false;
      case 3:
        return jobPost.isWed ?? false;
      case 4:
        return jobPost.isThu ?? false;
      case 5:
        return jobPost.isFri ?? false;
      case 6:
        return jobPost.isSat ?? false;
      case 7:
        return jobPost.isSun ?? false;
    }
  }

  updateWeekdaysStatus(int i) {
    switch (i) {
      case 1:
        jobPost.isMon = true;
      case 2:
        jobPost.isTue = false;
      case 3:
        jobPost.isWed = false;
      case 4:
        jobPost.isThu = false;
      case 5:
        jobPost.isFri = false;
      case 6:
        jobPost.isSat = false;
      case 7:
        jobPost.isSun = false;
    }
  }

  updateWeekdaysStatusUI(int i, bool status) {
    switch (i) {
      case 1:
        jobPost.isMon = status;
      case 2:
        jobPost.isTue = status;
      case 3:
        jobPost.isWed = status;
      case 4:
        jobPost.isThu = status;
      case 5:
        jobPost.isFri = status;
      case 6:
        jobPost.isSat = status;
      case 7:
        jobPost.isSun = status;
    }
    debugPrint('days $i :=> $status');
    debugPrint('days Monday :=> ${jobPost.isMon}');
  }

  var days = <DropdownItems>[
    DropdownItems(text: 'Sunday', value: 1),
    DropdownItems(text: 'Monday', value: 2),
    DropdownItems(text: 'Tuesday', value: 3),
    DropdownItems(text: 'Wednesday', value: 4),
    DropdownItems(text: 'Thursday', value: 5),
    DropdownItems(text: 'Friday', value: 6),
    DropdownItems(text: 'Saturday', value: 7),
  ];

  Future<void> loadFormData(int userPostId) async {
    try {
      var value = await http
          .httpGet("core/userposts/getUserPostByUserPostId/$userPostId");
      // .then((value) {

      List<dynamic> curr = value["Currencies"];
      listCurrency = Currency.fromJsonList(curr);

      List<dynamic> country = value["Countries"];
      listCountry = Country.fromJsonList(country);

      List<dynamic> jobType = value["JobTypes"];
      listJobType = JobType.fromJsonList(jobType);

      if (!FormUtil.isEdit) return;
      var userPosts = value["UserPost"][0];
      if (userPosts != null) {
        jobPost = JobPost.fromJson(userPosts);
        if (jobPost.fileDetail == null) return;
        List<dynamic> jsonList = jsonDecode(jobPost.fileDetail!);
        jobPost.files = FileDetail.fromJsonList(jsonList);
        serverImages.value.addAll(jobPost.files ?? []);
      } else {
        util.showToast("Fail to load the data");
      }
    } catch (e) {
      util.showToast("Fail to load the data");
    }
  }

  saveFormData() {
    bool flag = formKey.currentState!.validate();
    if (!flag) {
      util.showToast("Invalid form", type: Constants.fail);
      isSubmitted.value = false;
      return;
    }

    jobPost.isMon ??= false;
    jobPost.isTue ??= false;
    jobPost.isThu ??= false;
    jobPost.isWed ??= false;
    jobPost.isFri ??= false;
    jobPost.isSat ??= false;
    jobPost.isSun ??= false;

    if (jobPost.isMon! == true &&
        jobPost.isTue! == true &&
        jobPost.isThu! == true &&
        jobPost.isWed! == true &&
        jobPost.isFri! == true &&
        jobPost.isSat! == true &&
        jobPost.isSun! == true) {
      util.showToast("At least one week day should be week off",
          type: Constants.fail);
      return;
    } else if (jobPost.isMon! == false &&
        jobPost.isTue! == false &&
        jobPost.isThu! == false &&
        jobPost.isWed! == false &&
        jobPost.isFri! == false &&
        jobPost.isSat! == false &&
        jobPost.isSun! == false) {
      util.showToast("At least one week day should be working day",
          type: Constants.fail);
      return;
    }

    // // just for testing
    // return;

    if (FormUtil.isEdit) {
      updateFormData();
      return;
    }

    int i = 0;
    jobPost.files = [];
    var files = <FileDetail>[];
    for (var element in selectedFiles) {
      files.add(
        FileDetail(
          fileDetailId: ++i,
          filePath: element.path,
        ),
      );
    }

    // jobPost.fileDetail = jsonEncode(JobPost.getJsonList(files));
    jobPost.fileDetail = "[]";

    http
        .upload("core/userposts/uploadUserPostsMobile", pickedImages.value,
            JobPost.toJson(jobPost))
        .then((value) => {
              if (value != null || value == "success")
                {
                  Get.back(result: "Post published successfully"),
                }
              else
                {
                  updateIsSubmitted(false),
                  util.showToast("Fail to post. Please contact admin.",
                      type: Constants.fail),
                }
            });
  }

  updateFormData() {
    Posts passingPost;
    List<FileDetail> updatedFiles = [];
    http
        .upload("core/userposts/updateUserPostsMobile", pickedImages.value,
            JobPost.toJson(jobPost))
        .then((value) => {
              if (value != null)
                {
                  updatedFiles = JobPost.convertToList(value["files"]),
                  passingPost = Posts(
                    files: updatedFiles, postedBy: jobPost.postedBy,
                    shortDescription: jobPost.shortDescription,
                    completeDescription: jobPost.completeDescription,
                    fullName: jobPost.fullName,
                    userPostId: jobPost.userPostId,
                    // isLiked: jobPost.
                  ),
                  util.showToast('Post updated successfully'),
                  Get.back(result: passingPost),
                }
              else
                {
                  updateIsSubmitted(false),
                  util.showToast("Fail to post. Please contact admin.",
                      type: Constants.fail),
                }
            });
  }

  List<DropdownItems> categories = <DropdownItems>[
    DropdownItems(text: 'Driver', value: 1),
    DropdownItems(text: 'Electrician', value: 2),
    DropdownItems(text: 'Mechanical Fitter', value: 3),
  ];

  List<DropdownItems> countries = <DropdownItems>[
    DropdownItems(text: 'India', value: 1),
    DropdownItems(text: 'UAE', value: 2),
    DropdownItems(text: 'Qatar', value: 3),
  ];

  List<int> generateRandomNumber({int range = 50}) {
    return List.generate(range, (i) => i + 1);
  }

  void onItemSelected(DropdownItems value) {
    debugPrint("$value");
  }

  pickImages() async {
    try {
      isImagePicked.value = false;
      selectedFiles = await ImagePicker().pickMultiImage(limit: 5);
      if (selectedFiles.isNotEmpty) {
        pickedImages.value.addAll(selectedFiles);
        isFileReady.value = true;
      } else {
        isFileReady.value = false;
        util.showToast("Unable to pick any images");
      }

      isImagePicked.value = true;
    } on PlatformException catch (e) {
      isFileReady.value = false;
      debugPrint('Failed to pick image: $e');
    }
  }

  removeImage(String fileName) {
    selectedFiles.removeWhere((elem) => elem.name == fileName);
    pickedImages.value.clear();
    pickedImages.value.addAll(selectedFiles);
  }

  removeServerImage(FileDetail? file) {
    if (file?.filePath == null) return;
    serverImages.value.removeWhere((f) => f.filePath == file?.filePath);
    jobPost.files?.removeWhere((f) => f.filePath == file?.filePath);
    deletedFiles.add(file!);
    util.removeCachedImage(file.filePath!);
  }
}
