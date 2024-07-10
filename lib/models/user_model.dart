import 'dart:convert';

import 'package:hiringbell/models/user_document.dart';

class UserModel {
  int userId;
  String? firstName;
  String? lastName;
  String? fatherName;
  String? motherName;
  String? email;
  String? mobile;
  String? alternateNumber;
  String? address;
  String? city;
  int? pinCode;
  String? state;
  String? country;
  int? roleId;
  bool? isActive;
  int? jobCategoryId;
  String? categoryTypeIds;
  String? jobLocationIds;
  String? imageURL;
  int? createdBy;
  int? updatedBy;
  DateTime? createdOn;
  DateTime? updatedOn;
  DateTime? dateOfBirth;
  String? gender;
  bool? maritalStatus;
  int? religionId;
  String? nationality;
  DateTime? availabilityDate;
  int? educationId;
  bool? currentEmploymentStatus;
  int localExperience;
  int overseasExperience;
  String? password;
  List<int>? listJobLocationIds = [];
  List<int>? listJobTypeIds = [];
  List<UserDocument>? userDocs = [];
  List<int>? deletedDocsId = [];

  UserModel({
    required this.userId,
    this.firstName,
    this.lastName,
    this.fatherName,
    this.motherName,
    this.email,
    this.mobile,
    this.alternateNumber,
    this.address,
    this.city,
    this.pinCode,
    this.state,
    this.country,
    this.roleId,
    this.isActive,
    this.jobCategoryId,
    this.categoryTypeIds,
    this.jobLocationIds,
    this.imageURL,
    this.createdBy,
    this.updatedBy,
    this.createdOn,
    this.updatedOn,
    this.dateOfBirth,
    this.gender = 'm',
    this.maritalStatus,
    this.religionId,
    this.nationality,
    this.availabilityDate,
    this.educationId,
    this.currentEmploymentStatus,
    this.localExperience = 0,
    this.overseasExperience = 0,
    this.password,
    this.listJobLocationIds,
    this.listJobTypeIds,
    this.userDocs,
    this.deletedDocsId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    var jobTypeIds_ =
        (jsonDecode(json["categoryTypeIds"] ?? []) as List<dynamic>)
            .cast<int>();
    var jobLocationIds_ =
        (jsonDecode(json["jobLocationIds"] ?? []) as List<dynamic>).cast<int>();

    return UserModel(
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      fatherName: json['fatherName'],
      motherName: json['motherName'],
      email: json['email'],
      mobile: json['mobile'],
      alternateNumber: json['alternateNumber'],
      address: json['address'],
      city: json['city'],
      pinCode: json['pinCode'],
      state: json['state'],
      country: json['country'],
      roleId: json['roleId'],
      isActive: json['isActive'],
      jobCategoryId: json['jobCategoryId'],
      categoryTypeIds: json['categoryTypeIds'],
      jobLocationIds: json['jobLocationIds'],
      imageURL: json['imageURL'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdOn:
          json['createdOn'] != null ? DateTime.parse(json['createdOn']) : null,
      updatedOn:
          json['updatedOn'] != null ? DateTime.parse(json['updatedOn']) : null,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : null,
      gender: json['gender'],
      maritalStatus: json['maritalStatus'],
      religionId: json['religionId'],
      nationality: json['nationality'],
      availabilityDate: json['availabilityDate'] != null
          ? DateTime.parse(json['availabilityDate'])
          : null,
      educationId: json['educationId'],
      currentEmploymentStatus: json['currentEmploymentStatus'],
      localExperience: json['localExperience'],
      overseasExperience: json['overseasExperience'],
      password: json['password'],
      listJobLocationIds: jobLocationIds_,
      listJobTypeIds: jobTypeIds_,
      userDocs: UserDocument.fromJsonList(json["userDocs"]),
    );
  }

  static String convertListToString(List<int>? items) {
    if (items == null || items.isEmpty) return "[]";
    var res = items.join(",");
    return "[$res]";
  }

  static Map<String, dynamic> toJson(UserModel user) {
    return {
      'userId': user.userId,
      'firstName': user.firstName,
      'lastName': user.lastName,
      'fatherName': user.fatherName,
      'motherName': user.motherName,
      'email': user.email,
      'mobile': user.mobile,
      'alternateNumber': user.alternateNumber,
      'address': user.address,
      'city': user.city,
      'pinCode': user.pinCode,
      'state': user.state,
      'country': user.country,
      'roleId': user.roleId,
      'isActive': user.isActive,
      'jobCategoryId': user.jobCategoryId,
      'categoryTypeIds': convertListToString(user.listJobTypeIds),
      'jobLocationIds': convertListToString(user.listJobLocationIds),
      'imageURL': user.imageURL,
      'createdBy': user.createdBy,
      'updatedBy': user.updatedBy,
      'createdOn': user.createdOn?.toIso8601String(),
      'updatedOn': user.updatedOn?.toIso8601String(),
      'dateOfBirth': user.dateOfBirth?.toIso8601String(),
      'gender': user.gender,
      'maritalStatus': user.maritalStatus,
      'religionId': user.religionId,
      'nationality': user.nationality,
      'availabilityDate': user.availabilityDate?.toIso8601String(),
      'educationId': user.educationId,
      'currentEmploymentStatus': user.currentEmploymentStatus,
      'localExperience': user.localExperience,
      'overseasExperience': user.overseasExperience,
      'password': user.password,
      'userDocs': UserDocument.toJsonList(user.userDocs ?? []),
      'deletedDocsId': user.deletedDocsId,
    };
  }
}
