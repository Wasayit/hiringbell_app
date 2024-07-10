import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/api_response.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/models/dropdown_items.dart';
import 'package:hiringbell/models/education.dart';
import 'package:hiringbell/models/experience.dart';
import 'package:hiringbell/models/profile_detail.dart';
import 'package:hiringbell/models/user.dart';
import 'package:hiringbell/models/user_professional_detail.dart';
import 'package:hiringbell/pages/profile/widget/educational_detail/manage_education.dart';
import 'package:hiringbell/pages/profile/widget/experience/manage_experience.dart';
import 'package:hiringbell/services/http_service.dart';
import 'package:hiringbell/utilities/Util.dart';
import 'package:intl/intl.dart';

class ProfileController extends GetxController {
  BuildContext? context;
  final formKey = GlobalKey<FormState>();
  final experienceFormKey = GlobalKey<FormState>();

  // ------------------ text editing controllers for experience ----------------
  final roleNameController = TextEditingController();
  final companyNameController = TextEditingController();
  final roleDescriptionController = TextEditingController();
  final dojController = TextEditingController().obs;
  final dolController = TextEditingController().obs;
  final workLocationCountryName = "".obs;

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
        util.showToast("Please select your work location",
            type: Constants.fail);
        isSubmitted.value = false;
        return;
      }

      int professionalId = 0;
      if (profileDetail!.userProfessionalDetail != null) {
        professionalId =
            profileDetail!.userProfessionalDetail!.userProfessionalDetailId;
      }

      ApiResponse? result =
          await http.httpPost("core/user/updateProfileBasicInfo", {
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

  void handledSelectedWorkLocation(DropdownItems item) {
    Navigator.pop(context!);
    debugPrint(item.text);
    countryId = int.parse(item.value);
    workLocationCountryName.value = item.text;
  }

  Future<void> updateExperience() async {
    isSubmitted.value = true;

    try {
      var status = experienceFormKey.currentState!.validate();
      if (status) {
        var data = <String, Object>{};
        var doj = DateFormat('dd MMM, yyy').parse(dojController.value.text);
        var dol = DateFormat('dd MMM, yyy').parse(dolController.value.text);
        data = {
          "experienceId": profileDetail!.experience!.experienceId,
          "userId": 0,
          "roleName": roleNameController.text,
          "roleDescription": roleDescriptionController.text,
          "companyName": companyNameController.text,
          "doj": DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(doj),
          "dol": DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(dol),
          "countryName": workLocationCountryName.value,
        };

        ApiResponse? result =
            await http.httpPost("core/user/updateUserWorkExperience", data);

        if (result == null || result.responseBody == null) {
          util.showToast("Fail to update experience data",
              type: Constants.fail);
          isSubmitted.value = false;
          return;
        }

        profileDetail!.experience = Experience.fromJson(result.responseBody);
        util.showToast("Experience added/updated successfully");
        isReady.value = false;
        isSubmitted.value = false;
      } else {
        util.showToast("All fields are mandatory", type: Constants.fail);
      }
    } on Exception catch (_, ex) {
      isSubmitted.value = false;
      util.showToast("Please check your form, got error", type: Constants.fail);
    }
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

      aboutMeController.text =
          profileDetail!.userProfessionalDetail!.completeDescription!;
      util.showToast("Detail updated successfully");
      isReady.value = false;
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
    if (result == null) {
      util.showToast("Fail to load profile data.", type: Constants.fail);
      return;
    }

    if (result["UserProfessionalDetail"] != null) {
      profileDetail!.userProfessionalDetail =
          UserProfessionalDetail.fromJson(result["UserProfessionalDetail"]);

      var experiences = result["Experience"] as List<dynamic>;
      if (experiences.isNotEmpty) {
        profileDetail!.experience = Experience.fromJson(experiences[0]);
        experienceFlag.value = true;
      }

      var education = result["Education"] as List<dynamic>;
      if (education.isNotEmpty) {
        profileDetail!.education = Education.fromJson(education[0]);
      }

      jobTitleController.text = profileDetail!.userProfessionalDetail!.title!;
      jobShortDescController.text =
          profileDetail!.userProfessionalDetail!.shortDescription!;
      countryName.value =
          profileDetail!.userProfessionalDetail!.presentWorkLocation!;

      if (profileDetail!.userProfessionalDetail!.completeDescription != null &&
          profileDetail!.userProfessionalDetail!.completeDescription!.isNotEmpty) {
        aboutMeFlag.value = true;
        aboutMeController.text =
            profileDetail!.userProfessionalDetail!.completeDescription!;
      }
      isBasicInfoIsReady.value = true;
    } else {
      isBasicInfoIsReady.value = false;
    }

    profileDetail!.userDetail = User.fromJson(result["User"]);
    isReady.value = true;
  }

  Future<void> onDateSelected(bool isDOJ) async {
    DateTime? selectedDate = await showDatePicker(
        context: context!,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(2030));
    if (selectedDate != null) {
      String formattedDate = DateFormat('dd MMM, yyy').format(selectedDate);
      if (isDOJ) {
        doaController.value.text = formattedDate.toString();
      } else {
        dolController.value.text = formattedDate.toString();
      }
    }
  }

  Future<void> onSelectPassOutYear() async {
    DateTime? selectedDate = await showDatePicker(
        context: context!,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(2030));
    if (selectedDate != null) {
      doaController.value.text = selectedDate.year.toString();
    }
  }

  void addManageExperience() {
    workLocationCountryName.value = "";
    dojController.value.text = Constants.empty;
    dolController.value.text = Constants.empty;
    roleNameController.text = Constants.empty;
    roleDescriptionController.text = Constants.empty;
    companyNameController.text = Constants.empty;

    Get.to(
      ManageExperience(
        experience: Experience.noArgs(),
      ),
    )?.then(
      (_) => {
        if (!isReady.value)
          {
            reloadPage(),
          }
      },
    );
  }

  void loadManageExperience() {
    workLocationCountryName.value = profileDetail!.experience!.countryName!;
    dojController.value.text = profileDetail!.experience!.doj!;
    dolController.value.text = profileDetail!.experience!.doj!;
    roleNameController.text = profileDetail!.experience!.roleName!;
    roleDescriptionController.text = profileDetail!.experience!.roleDescription;
    companyNameController.text = profileDetail!.experience!.companyName!;

    Get.to(
      ManageExperience(
        experience: Experience.noArgs(),
      ),
    )?.then(
      (_) => {
        if (!isReady.value)
          {
            reloadPage(),
          }
      },
    );
  }

  //------------------------- education section --------------------

  var educationTypeController = TextEditingController();
  var universityBoardController = TextEditingController();
  var collegeSchollController = TextEditingController();
  var doaController = TextEditingController().obs;
  var universityBoardCountry = "".obs;
  final educationForm = GlobalKey<FormState>();

  int duration = 0;
  int educationTypeId = 0;

  void addEducation() {
    Get.to(
      ManageEducation(
        education: profileDetail!.education!,
      ),
    )?.then(
      (_) => {
        if (!isReady.value)
          {
            reloadPage(),
          }
      },
    );
  }

  void editEducation() {
    universityBoardController.text = profileDetail!.education!.universityOrBoardName;
    educationTypeId = profileDetail!.education!.educationTypeId;
    collegeSchollController.text = profileDetail!.education!.collageOrSchoolName;
    duration = profileDetail!.education!.duration;
    universityBoardCountry.value = profileDetail!.education!.country;
    doaController.value.text = profileDetail!.education!.yearOfPassout.toString();

    Get.to(
      ManageEducation(
        education: profileDetail!.education!,
      ),
    )?.then(
      (_) => {
        if (!isReady.value)
          {
            reloadPage(),
          }
      },
    );
  }

  void handledUniversityBoardCountry(DropdownItems item) {
    Navigator.pop(context!);
    universityBoardCountry.value = item.text;
  }

  Future<void> addEducationDetail() async {
    var endpoint = "core/user/addEducationalDetail";
    saveEducationalDetail(endpoint, 0);
  }

  Future<void> updateEducationDetail() async {
    var endpoint = "core/user/updateEducationalDetail";
    int educationId = profileDetail!.education!.educationId;
    if (educationId <= 0) {
      util.showToast("Invalid education detail selected", type: Constants.fail);
      return;
    }
      
    saveEducationalDetail(endpoint, educationId);
  }

  Future<void> saveEducationalDetail(String endpoint, int educationId) async {
    isSubmitted.value = true;

    try {
      bool status = educationForm.currentState!.validate();
      if (status) {
        var result =
            await http.httpPost(endpoint, {
              "educationId": educationId,
              "educationTypeId": educationTypeId,
              "universityOrBoardName": universityBoardController.value.text,
              "collageOrSchoolName": collegeSchollController.value.text,
              "yearOfPassout": doaController.value.text,
              "duration": duration,
              "country": universityBoardCountry.value,
            });

        if (result == null || result.responseBody == null) {
          util.showToast("Fail to update educational data", type: Constants.fail);
          isSubmitted.value = false;
          return;
        }

        profileDetail!.education = Education.fromJson(result.responseBody);
        util.showToast("Educational detail added/updated successfully");
        isReady.value = false;
        isSubmitted.value = false;
      } else {
        util.showToast("Please mandatory fields", type: Constants.fail);
      }

      isReady.value = false;
      isSubmitted.value = false;
    } on Exception catch (_, e) {
      isSubmitted.value = false;
    }
  }
}
