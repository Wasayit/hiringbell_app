import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/api_response.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/models/dropdown_items.dart';
import 'package:hiringbell/models/profile_detail.dart';
import 'package:hiringbell/models/user.dart';
import 'package:hiringbell/models/user_professional_detail.dart';
import 'package:hiringbell/services/http_service.dart';
import 'package:hiringbell/utilities/Util.dart';

class ProfileController extends GetxController {
  BuildContext? context;
  final formKey = GlobalKey<FormState>();
  final experienceFormKey = GlobalKey<FormState>();

  // ------------------ text editing controllers for experience ----------------
  final roleNameController = TextEditingController();
  final companyNameController = TextEditingController();
  final jobDescController = TextEditingController();
  final dojController = TextEditingController();
  final dolController = TextEditingController();

  User user = User();
  ProfileDetail? profileDetail;

  late Util util;
  var http = HttpService.getInstance();

  //------------- widget update flags ------------------
  var isReady = false.obs;
  var countryName = "".obs;
  var isSubmitted = false.obs;
  var isBasicInfoIsReady = false.obs;
  var aboutMeFlag = false.obs;
  var experienceFlag = false.obs;
  var educationFlag = false.obs;
  var skillsFlag = false.obs;
  var interestsFlag = false.obs;

  var jobTitleController = TextEditingController();
  var jobShortDescController = TextEditingController();
  var aboutMeController = TextEditingController();
  int countryId = 0;

  Future<void> onRefresh() async {
    debugPrint("Refreshing page...");
  }

  setContext(BuildContext buildContext) => context = buildContext;

  @override
  void onInit() {
    super.onInit();
    util = Util.getInstance();
    user = util.getUserDetail();
/*

    profileDetail = ProfileDetail(
      description: "description",
      education: Education(
          educationId: 10,
          educationName: "BTech"
      ),
      experience: Experience(),
      skills: Skills(),
      interests: Interests(),
    );
*/

    profileDetail = ProfileDetail.noArgument();
  }

  void handleSelectedCountry(DropdownItems item) {
    Navigator.pop(context!);
    debugPrint(item.text);
    countryId = int.parse(item.value);
    countryName.value = item.text;
  }

  Future<void> saveUserBasicInfo() async {
    isBasicInfoIsReady.value = false;
    isSubmitted.value = true;

    try {
      bool flag = formKey.currentState!.validate();
      if (!flag) {
        isSubmitted.value = false;
        return;
      }

      if (countryName.value.isEmpty) {
        util.showToast(
            "Please select your work location", type: Constants.fail);
        isSubmitted.value = false;
        return;
      }

      int professionalId = 0;
      if (profileDetail!.userProfessionalDetail != null) {
        professionalId =
            profileDetail!.userProfessionalDetail!.userProfessionalDetailId;
      }

      ApiResponse? result = await http.httpPost(
          "core/user/updateProfileBasicInfo", {
        "userProfessionalDetailId": professionalId,
        "title": jobTitleController.text,
        "shortDescription": jobShortDescController.text,
        "presentWorkLocation": countryName.value,
      });

      if (result == null || result.responseBody == null) {
        util.showToast("Fail to save the detail.", type: Constants.fail);
        isSubmitted.value = false;
        return;
      }

      profileDetail!.userProfessionalDetail =
          UserProfessionalDetail.fromJson(result.responseBody);
      if (profileDetail!.userProfessionalDetail!.userProfessionalDetailId ==
          0) {
        util.showToast("Fail to save the detail.", type: Constants.fail);
      }

      jobTitleController.text = profileDetail!.userProfessionalDetail!.title!;
      jobShortDescController.text =
      profileDetail!.userProfessionalDetail!.shortDescription!;
      countryName.value =
      profileDetail!.userProfessionalDetail!.presentWorkLocation!;
      isBasicInfoIsReady.value = true;

      util.showToast("User information updated successfully");
      isSubmitted.value = false;
    } on Exception catch (_, ex) {
      util.showToast("Fail to save the detail.", type: Constants.fail);
      isSubmitted.value = false;
    }
  }

  Future<void> updateExperience() async {
    var status = experienceFormKey.currentState!.validate();
  }

  Future<void> updateAboutMeDetail() async {
    isSubmitted.value = true;

    try {
      if (aboutMeController.text.isEmpty) {
        await Util.delayScreen(2);
        util.showToast("About me field is required", type: Constants.fail);
        isSubmitted.value = false;
        return;
      }

      var result = await http.httpPost("core/user/updateAboutMe", {
        "completeDescription": aboutMeController.text,
      });

      if (result == null || result.responseBody == null) {
        util.showToast("Fail to save the detail.", type: Constants.fail);
        isSubmitted.value = false;
        return;
      }

      profileDetail!.userProfessionalDetail =
          UserProfessionalDetail.fromJson(result.responseBody);
      if (profileDetail!.userProfessionalDetail!.userProfessionalDetailId ==
          0) {
        util.showToast("Fail to save the detail.", type: Constants.fail);
      }

      aboutMeController.text = profileDetail!.userProfessionalDetail!.completeDescription!;
      util.showToast("Detail updated successfully");
      aboutMeFlag.value = true;
      isSubmitted.value = false;
    } on Exception catch (_, ex) {
      util.showToast("Fail to save the detail.", type: Constants.fail);
      isSubmitted.value = false;
    }
  }

  Future<void> reloadPage() async {
    await loadProfilePage();
  }

  Future<void> loadProfilePage() async {
    var result = await http.httpGet("core/user/getProfile/${user.userId}");
    if(result == null) {
      util.showToast("Fail to load profile data.", type: Constants.fail);
      return;
    }

    if(result["UserProfessionalDetail"] != null) {
      profileDetail!.userProfessionalDetail =
          UserProfessionalDetail.fromJson(result["UserProfessionalDetail"]);
      jobTitleController.text =
      profileDetail!.userProfessionalDetail!.title!;
      jobShortDescController.text =
      profileDetail!.userProfessionalDetail!.shortDescription!;
      countryName.value =
      profileDetail!.userProfessionalDetail!.presentWorkLocation!;
      isBasicInfoIsReady.value = true;
    } else {
      isBasicInfoIsReady.value = false;
    }

    profileDetail!.userDetail = User.fromJson(result["User"]);
    isReady.value = true;
  }
}
