import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/models/country.dart';
import 'package:hiringbell/models/files.dart';
import 'package:hiringbell/models/job_type.dart';
import 'package:hiringbell/models/dropdown_items.dart';
import 'package:hiringbell/models/post_job.dart';
import 'package:hiringbell/models/posts.dart';
import 'package:hiringbell/pages/common/bt_select/form_util.dart';
import 'package:hiringbell/services/http_service.dart';
import 'package:hiringbell/utilities/Util.dart';
import 'package:image_picker/image_picker.dart';

class PostNewJobController extends GetxController {
  BuildContext? context;
  final formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey titleFieldKey = GlobalKey();
  final GlobalKey descriptionFieldKey = GlobalKey();
  final GlobalKey vacancyFieldKey = GlobalKey();
  final GlobalKey minSalaryFieldKey = GlobalKey();
  final GlobalKey maxSalaryFieldKey = GlobalKey();

  var isSubmitted = false.obs;
  final isLoading = RxBool(false);
  final http = HttpService.getInstance();
  final jobTitle = TextEditingController();
  final jobDescription = TextEditingController();
  final util = Util.getInstance();
  List<XFile> selectedFiles = [];

  var serverImages = RxList<FileDetail>([]).obs;
  var pickedImages = RxList<XFile>([]).obs;
  var isFileReady = false.obs;
  var overtimeFlag = false.obs;
  List<FileDetail> deletedFiles = [];

  var openFlags = [false, false, false].obs;
  var experienceFlag = false.obs;
  var genderId = 0.obs;
  var countryName = "".obs;
  var jobTypeName = "".obs;

  setContext(BuildContext buildContext) => context = buildContext;

  void resetState() {
    isFileReady = false.obs;
  }

  void genderSelected(int id) {
    jobPost.gender = id;
    genderId.value = id;
    Navigator.pop(context!);
  }

  List<JobType> listJobType = [];
  List<Country> listCountry = [];
  List<int> listMinAge = Util.genSequence(18, 45);
  List<int> listMaxAge = Util.genSequence(18, 45);
  List<int> listOverTime = Util.genSequence(0, 10);
  List<int> listDailyWorkingHours = Util.genSequence(1, 12);
  List<int> listExperience = Util.genSequence(0, 25);

  List<DropdownItems> categories = [];
  List<DropdownItems> countries = [];

  JobPost jobPost = JobPost.noArg();
  int? _jobPostId;

  void setPostId(int jobPostId) => _jobPostId = jobPostId;

  Future<void> onInitRefresh() async {
    _jobPostId ??= 0;
    FormUtil.isEdit = (_jobPostId! > 0);
    try {
      isLoading(true);
      await loadFormData();
    } finally {
      isLoading(false);
    }
  }

  updateIsSubmitted(bool flag) {
    isSubmitted.value = flag;
  }

  Future<void> loadFormData() async {
    try {
      var value = await http
          .httpGet("core/userposts/getUserPostByUserPostId/$_jobPostId");
      // .then((value) {

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

  void getInitForm() {
    jobPost = JobPost.noArg();
    jobPost.gender = 1;
    genderId.value = 1;
  }

  void handleSelectedCountry(DropdownItems item) {
    Navigator.pop(context!);
    jobPost.countryName = item.text;
    jobPost.countryId = int.parse(item.value);
    countryName.value = item.text;
  }

  void handleSelectedJobType(DropdownItems item) {
    Navigator.pop(context!);
    jobPost.jobTypeId = int.parse(item.value);
    jobTypeName.value = item.text;
  }

  saveFormData() {
    updateIsSubmitted(true);
    bool flag = formKey.currentState!.validate();
    if (!flag) {
      isSubmitted.value = false;
      return;
    }

    if (jobPost.countryName == null ||
        jobPost.countryName!.isEmpty ||
        jobPost.countryId == 0) {
      util.showToast("Please select country, it mandatory",
          type: Constants.fail);
    }

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
                    files: updatedFiles,
                    postedBy: jobPost.postedBy,
                    shortDescription: jobPost.shortDescription,
                    completeDescription: jobPost.completeDescription,
                    fullName: jobPost.fullName,
                    userPostId: jobPost.userPostId,
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

  List<int> generateRandomNumber({int range = 50}) {
    return List.generate(range, (i) => i + 1);
  }

  pickImages() async {
    try {
      selectedFiles = await ImagePicker().pickMultiImage(limit: 5);
      if (selectedFiles.isNotEmpty) {
        pickedImages.value.addAll(selectedFiles);
        isFileReady.value = true;
      } else {
        isFileReady.value = false;
        util.showToast("Unable to pick any images");
      }
    } on PlatformException catch (e) {
      isFileReady.value = false;
      debugPrint('Failed to pick image: $e');
    }
  }

  removeImage(String fileName) {
    selectedFiles.removeWhere((elem) => elem.name == fileName);
    pickedImages.value.clear();
    pickedImages.value.addAll(selectedFiles);
    if (pickedImages.value.isEmpty) {
      isFileReady.value = false;
    }
  }

  removeServerImage(FileDetail? file) {
    if (file?.filePath == null) return;
    serverImages.value.removeWhere((f) => f.filePath == file?.filePath);
    jobPost.files?.removeWhere((f) => f.filePath == file?.filePath);
    deletedFiles.add(file!);
    util.removeCachedImage(file.filePath!);
  }
}
