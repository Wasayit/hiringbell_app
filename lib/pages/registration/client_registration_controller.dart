import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/models/country.dart';
import 'package:hiringbell/models/education.dart';
import 'package:hiringbell/models/files.dart';
import 'package:hiringbell/models/job_type.dart';
import 'package:hiringbell/models/dropdown_items.dart';
import 'package:hiringbell/models/language.dart';
import 'package:hiringbell/models/religion.dart';
import 'package:hiringbell/models/user_document.dart';
import 'package:hiringbell/models/user_model.dart';
import 'package:hiringbell/pages/common/bt_select/form_util.dart';
import 'package:hiringbell/services/http_service.dart';
import 'package:hiringbell/utilities/util.dart';
import 'package:image_picker/image_picker.dart';

class ClientRegistrationController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var isSubmitted = false.obs;
  final isLoading = RxBool(false);
  final http = HttpService.getInstance();
  final util = Util.getInstance();
  var documents = <UserDocument>[].obs;

  var isEducated = false.obs;
  var isImagePicked = true.obs;
  var serverImage = FileDetail().obs;
  // var isFileReady = false.obs;
  var pickedImage = Rx<XFile?>(null);
  var pickedDocumnets = RxList<XFile>([]).obs;
  // List<int> deletedSavedDocIds = [];
  var userSavedDocs = <UserDocument>[].obs;

  UserModel user = UserModel(userId: 0);

  int? regId_;
  bool isJobSeeker_;
  ClientRegistrationController({this.regId_, this.isJobSeeker_ = false});

  List<int> listExperience = Util.genSequence(0, 25);

  List<JobType> listJobType = [];
  List<Country> listCountry = [];
  List<Religion> listReligion = [];
  List<Education> listEducation = [];
  List<Language> listLanguage = [];

  List<DropdownItems<String>> listGender = [
    DropdownItems(text: 'Male', value: 'm'),
    DropdownItems(text: 'Female', value: 'f'),
    DropdownItems(text: 'Other', value: 'o'),
  ];

  List<DropdownItems<bool>> listYesNo = [
    DropdownItems(text: 'Yes', value: true),
    DropdownItems(text: 'No', value: false),
  ];

  // List<DropdownItems<int>> listReligion = [
  //   DropdownItems(text: 'Christianity', value: 1),
  //   DropdownItems(text: 'Islam', value: 2),
  //   DropdownItems(text: 'Hinduism', value: 3),
  //   DropdownItems(text: 'Buddhism', value: 4),
  //   DropdownItems(text: 'Judaism', value: 5),
  //   DropdownItems(text: 'Other', value: 6),
  // ];

  // List<DropdownItems<int>> listEducation = [
  //   DropdownItems(text: 'High School', value: 1),
  //   DropdownItems(text: 'Diploma', value: 2),
  //   DropdownItems(text: 'Undergraduate', value: 3),
  //   DropdownItems(text: 'Graduate', value: 4),
  //   DropdownItems(text: 'Post Graduate', value: 5),
  //   DropdownItems(text: 'Doctorate', value: 6),
  // ];

  // final List<DropdownItems<int>> listCountry = [
  //   DropdownItems(value: 1, text: 'India'),
  //   DropdownItems(value: 2, text: 'United States'),
  //   DropdownItems(value: 3, text: 'China'),
  //   DropdownItems(value: 4, text: 'Brazil'),
  //   DropdownItems(value: 5, text: 'Russia'),
  //   DropdownItems(value: 6, text: 'Japan'),
  //   DropdownItems(value: 7, text: 'Germany'),
  //   DropdownItems(value: 8, text: 'France'),
  //   DropdownItems(value: 9, text: 'United Kingdom'),
  //   DropdownItems(value: 10, text: 'Australia'),
  // ];

  final List<DropdownItems<int>> listStates = [
    DropdownItems(value: 1, text: 'Telangana'),
    DropdownItems(value: 2, text: 'Karnataka'),
    DropdownItems(value: 3, text: 'Andhra Pradesh'),
    DropdownItems(value: 4, text: 'Tamil Nadu'),
    DropdownItems(value: 5, text: 'Maharashtra'),
    DropdownItems(value: 6, text: 'Kerala'),
    DropdownItems(value: 7, text: 'Gujarat'),
    DropdownItems(value: 8, text: 'Rajasthan'),
    DropdownItems(value: 9, text: 'Uttar Pradesh'),
    DropdownItems(value: 10, text: 'Punjab'),
  ];

  final List<DropdownItems<int>> listCities = [
    DropdownItems(value: 1, text: 'Hyderabad'),
    DropdownItems(value: 2, text: 'Warangal'),
    DropdownItems(value: 3, text: 'Karimnagar'),
    DropdownItems(value: 4, text: 'Khammam'),
    DropdownItems(value: 5, text: 'Nizamabad'),
    DropdownItems(value: 6, text: 'Mahbubnagar'),
    DropdownItems(value: 7, text: 'Siddipet'),
    DropdownItems(value: 8, text: 'Adilabad'),
    DropdownItems(value: 9, text: 'Jagtial'),
    DropdownItems(value: 10, text: 'Nirmal'),
  ];

  Future<void> onInitRefresh() async {
    regId_ ??= 0;
    FormUtil.isEdit = (regId_! > 0);
    try {
      isLoading(true);
      await loadFormData(regId_!);
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadFormData(int userId) async {
    try {
      var value = await http
          .httpGet("core/user/getUserByUserIdWithRelatedData/$userId");
      // .then((value) {

      List<dynamic> edu = value["Educations"];
      listEducation = Education.fromJsonList(edu);

      List<dynamic> religion = value["Religions"];
      listReligion = Religion.fromJsonList(religion);

      List<dynamic> jobType = value["JobTypes"];
      listJobType = JobType.fromJsonList(jobType);

      List<dynamic> lang = value["Languages"];
      listLanguage = Language.fromJsonList(lang);

      List<dynamic> country = value["Countries"];
      listCountry = Country.fromJsonList(country);

      if (!FormUtil.isEdit) return;
      var user_ = value["User"][0];
      if (user_ != null) {
        user = UserModel.fromJson(user_);
        // if (user.userDocs != null && user.userDocs!.isNotEmpty) {
        List<dynamic> uDocs = value["UserDocs"];
        var listDocs = UserDocument.fromJsonList(uDocs);
        user.userDocs = List.from(listDocs);
        userSavedDocs.value = listDocs;
        // documents.value = listDocs;
        // } else {
        //   user.userDocs = [];
        //   documents.value = [];
        // }

        if ((user.educationId ?? 0) > 0) isEducated.value = true;
        // if (jobPost.fileDetail == null) return;
        // List<dynamic> jsonList = jsonDecode(jobPost.fileDetail!);
        // jobPost.files = FileDetail.fromJsonList(jsonList);
        // serverImages.value.addAll(jobPost.files ?? []);
      } else {
        util.showToast("Fail to load the data");
      }
    } catch (e) {
      util.showToast("Fail to load the data");
    }
  }

  pickImage() async {
    try {
      isImagePicked.value = false;
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      var isFilePicked = (pickedFile != null);
      if (isFilePicked) {
        pickedImage.value = pickedFile;
        // isFileReady.value = true;
      } else {
        // isFileReady.value = false;
        util.showToast("Unable to pick an image");
      }

      isImagePicked.value = isFilePicked;
    } on PlatformException catch (e) {
      // isFileReady.value = false;
      debugPrint('Failed to pick an image: $e');
    }
  }

  pickDocument() async {
    try {
      isImagePicked.value = false;
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      var isFilePicked = (pickedFile != null);
      if (isFilePicked) {
        documents.add(UserDocument());
        pickedDocumnets.value.add(pickedFile);

        // isFileReady.value = true;
      } else {
        // isFileReady.value = false;
        util.showToast("Unable to pick an image", type: Constants.warning);
      }

      isImagePicked.value = isFilePicked;
    } on PlatformException catch (e) {
      // isFileReady.value = false;
      debugPrint('Failed to pick an image: $e');
    }
  }

  void removeSavedDocument(int index) {
    // pickedDocumnets.value.removeAt(index);
    // var deletedDoc = documents.removeAt(index);

    // var checkingUser = user.userDocs;
    var deletedDoc = userSavedDocs.removeAt(index);
    if (deletedDoc != null && deletedDoc.docId > 0) {
      user.deletedDocsId ??= [];
      user.deletedDocsId?.add(deletedDoc.docId);
    }
  }

  void removePickedDocument(int index) {
    pickedDocumnets.value.removeAt(index);
    documents.removeAt(index);
  }

  saveFormData() {
    bool flag = formKey.currentState!.validate();
    if (!flag) {
      util.showToast("Invalid form", type: Constants.fail);
      isSubmitted.value = false;
      return;
    }
    user.roleId = 1;
    user.nationality = "Indian";

    // if (user.userDocs?.length != pickedDocumnets.value.length) {
    //   util.showToast("Check documents, error ", type: Constants.fail);
    //   isSubmitted.value = false;
    //   return;
    // }
    var jsonUser = UserModel.toJson(user);
    if (FormUtil.isEdit) {
      updateFormData(jsonUser);
      return;
    }
    user.userDocs = documents.value;
    // return;
    http
        .uploadUser("core/user/addUserMobile", pickedImage.value,
            pickedDocumnets.value, jsonUser)
        .then((value) => {
              if (value != null || value == "success")
                {
                  util.showToast("User Registered successfully"),
                  Get.back(result: "User Registered successfully"),
                }
              else
                {
                  isSubmitted(false),
                  util.showToast("Fail to Register. Please contact admin.",
                      type: Constants.fail),
                }
            });
  }

  updateFormData(Map<String, dynamic> jsonUser) {
    http
        .uploadUser("core/user/updateUserMobile/${user.userId}",
            pickedImage.value, pickedDocumnets.value, jsonUser)
        .then((value) => {
              if (value != null)
                {
                  util.showToast('user profile updated successfully'),
                  Get.back(result: "success"),
                }
              else
                {
                  isSubmitted.value = false,
                  util.showToast(
                      "Failed to Update profile details. Please contact admin.",
                      type: Constants.fail),
                }
            });
  }
}
