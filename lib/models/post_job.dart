import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/models/files.dart';
import 'package:hiringbell/utilities/Util.dart';

class JobPost {
  int userPostId = 0;
  String? shortDescription = Constants.empty;
  int categoryTypeId = 0;
  int postedBy = 0;
  DateTime? postedOn;
  String? fileDetail;
  List<FileDetail>? files = [];
  int jobCategoryId = 1;
  int jobRequirementId = 0;
  String? requiredShortDesc;
  String? completeDescription;
  int jobTypeId = 0;
  int clientId = 0;
  int? agentId = 0;
  int? partnerId = 0;
  int shiftId = 0;
  bool? isHRAAllowance = false;
  double? hRAAllowanceAmount = 0.0;
  bool? isTravelAllowance = false;
  double? travelAllowanceAmount = 0.0;
  bool? isFoodAllowance = false;
  double? foodAllowanceAmount = 0.0;
  bool? isForeignReturnCompulsory = false;
  int minimumDaysRequired = 0;
  int? certificateRequiredId = 0;
  double minimumCTC = 0;
  double maximumCTC = 0;
  bool isOTIncluded = false;
  int? maxOTHours = 0;
  double? bonus = 0.0;
  int countryId = 0;
  int minAgeLimit = 0;
  int maxAgeLimit = 0;
  int noOfPosts = 0;
  int salaryCurrency = 0;
  int? contractPeriodInMonths = 0;
  int createdBy = 0;
  int? updatedBy = 0;
  DateTime? createdOn;
  DateTime? updatedOn;
  int dailyWorkingHours = 0;
  int visaType = 0;
  bool isMedicalInsuranceProvide = false;
  int overseasExperience = 0;
  int localExperience = 0;
  DateTime? jobAppliedOn;
  DateTime? jobSavedOn;
  bool? isMon;
  bool? isTue;
  bool? isThu;
  bool? isWed;
  bool? isFri;
  bool? isSat;
  bool? isSun;

  // New fields
  int? roleId = 1;
  String? profileImage = Constants.empty;
  String? fullName;
  String? jobTypeName;
  String? countryName;
  String? currencyName;
  int gender = 1;

  JobPost.noArg();

  JobPost({
    required this.userPostId,
    this.shortDescription,
    // required this.categoryTypeId,
    required this.postedBy,
    this.postedOn,
    required this.fileDetail,
    this.files,
    required this.jobCategoryId,
    required this.jobRequirementId,
    this.requiredShortDesc,
    this.completeDescription,
    required this.gender,
    required this.jobTypeId,
    required this.clientId,
    this.agentId,
    this.partnerId,
    required this.shiftId,
    this.isHRAAllowance,
    this.hRAAllowanceAmount,
    this.isTravelAllowance,
    this.travelAllowanceAmount,
    this.isFoodAllowance,
    this.foodAllowanceAmount,
    this.isForeignReturnCompulsory,
    required this.minimumDaysRequired,
    this.certificateRequiredId,
    required this.minimumCTC,
    required this.maximumCTC,
    required this.isOTIncluded,
    this.maxOTHours,
    this.bonus,
    required this.countryId,
    required this.minAgeLimit,
    required this.maxAgeLimit,
    required this.noOfPosts,
    required this.salaryCurrency,
    this.contractPeriodInMonths,
    required this.createdBy,
    this.updatedBy,
    this.createdOn,
    this.updatedOn,
    required this.dailyWorkingHours,
    required this.visaType,
    required this.isMedicalInsuranceProvide,
    required this.overseasExperience,
    required this.localExperience,
    this.roleId,
    this.profileImage,
    this.fullName,
    this.jobTypeName,
    this.countryName,
    this.currencyName,
    this.jobAppliedOn,
    this.jobSavedOn,
    this.isMon,
    this.isTue,
    this.isThu,
    this.isWed,
    this.isFri,
    this.isSat,
    this.isSun,
  });

  static List<FileDetail> convertToList(dynamic jsonFiles) {
    List<dynamic> dFiles = jsonFiles;
    List<FileDetail> files = [];
    for (var i = 0; i < dFiles.length; i++) {
      files.add(FileDetail.fromJson(dFiles[i]));
    }

    return files;
  }

  static List<Map<String, dynamic>> getJsonList(List<FileDetail> fileDetail) {
    List<Map<String, dynamic>> map = [];

    if (fileDetail.isEmpty) return map;

    for (var file in fileDetail) {
      map.add(FileDetail.toJson(file));
    }

    return map;
  }

  static double convertToDouble(dynamic value) {
    if (value == null) {
      return 0.0;
    } else if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else {
      throw ArgumentError('Unexpected value type: ${value.runtimeType}');
    }
  }

  static int salaryConverter(dynamic value) {
    if (value == null) {
      return 1;
    }
    try {
      return int.parse(value);
    } catch (ex) {
      return 1;
    }
  }

  static Map<String, dynamic> toJson(JobPost data) {
    return {
      'userPostId': data.userPostId,
      'shortDescription': data.shortDescription,
      // 'categoryTypeId': data.categoryTypeId,
      'postedBy': data.postedBy,
      'postedOn': data.postedOn?.toIso8601String(),
      'fileDetail': data.fileDetail,
      'files': data.files == null ? [] : getJsonList(data.files!),
      'jobCategoryId': data.jobCategoryId,
      'jobRequirementId': data.jobRequirementId,
      'requiredShortDesc': data.requiredShortDesc,
      'completeDescription': data.completeDescription,
      'gender': data.gender,
      'jobTypeId': data.jobTypeId,
      'clientId': data.clientId,
      'agentId': data.agentId,
      'partnerId': data.partnerId,
      'shiftId': data.shiftId,
      'isHRAAllowance': data.isHRAAllowance,
      'hRAAllowanceAmount': data.hRAAllowanceAmount,
      'isTravelAllowance': data.isTravelAllowance,
      'travelAllowanceAmount': data.travelAllowanceAmount,
      'isFoodAllowance': data.isFoodAllowance,
      'foodAllowanceAmount': data.foodAllowanceAmount,
      'isForeignReturnCompulsory': data.isForeignReturnCompulsory,
      'minimumDaysRequired': data.minimumDaysRequired,
      'certificateRequiredId': data.certificateRequiredId,
      'minimumCTC': data.minimumCTC,
      'maximumCTC': data.maximumCTC,
      'isOTIncluded': data.isOTIncluded,
      'maxOTHours': data.maxOTHours,
      'bonus': data.bonus,
      'countryId': data.countryId,
      'minAgeLimit': data.minAgeLimit,
      'maxAgeLimit': data.maxAgeLimit,
      'noOfPosts': data.noOfPosts,
      'salaryCurrency': data.salaryCurrency,
      'contractPeriodInMonths': data.contractPeriodInMonths,
      'createdBy': data.createdBy,
      'updatedBy': data.updatedBy,
      'createdOn': data.createdOn?.toIso8601String(),
      'updatedOn': data.updatedOn?.toIso8601String(),
      'dailyWorkingHours': data.dailyWorkingHours,
      'visaType': data.visaType,
      'isMedicalInsuranceProvide': data.isMedicalInsuranceProvide,
      'overseasExperience': data.overseasExperience,
      'localExperience': data.localExperience,
      'isMon': data.isMon,
      'isTue': data.isTue,
      'isThu': data.isThu,
      'isWed': data.isWed,
      'isFri': data.isFri,
      'isSat': data.isSat,
      'isSun': data.isSun,
    };
  }

  factory JobPost.fromJson(dynamic json) {
    return JobPost(
      userPostId: json['userPostId'],
      shortDescription: json['shortDescription'],
      // categoryTypeId: json['categoryTypeId'],
      postedBy: json['postedBy'],
      postedOn: Util.convertToDateTime(json['postedOn']),
      fileDetail: json['fileDetail'],
      files: convertToList(json['files'] ?? []),
      jobCategoryId: json['jobCategoryId'],
      jobRequirementId: json['jobRequirementId'],
      requiredShortDesc: json['requiredShortDesc'],
      completeDescription: json['completeDescription'],
      gender: json['gender'] ?? 1,
      jobTypeId: json['jobTypeId'],
      clientId: json['clientId'] ?? 0,
      agentId: json['agentId'],
      partnerId: json['partnerId'],
      shiftId: json['shiftId'] ?? 0,
      isHRAAllowance: json['isHRAAllowance'],
      hRAAllowanceAmount: convertToDouble(json['hRAAllowanceAmount']),
      isTravelAllowance: json['isTravelAllowance'],
      travelAllowanceAmount: convertToDouble(json['travelAllowanceAmount']),
      isFoodAllowance: json['isFoodAllowance'],
      foodAllowanceAmount: convertToDouble(json['foodAllowanceAmount']),
      isForeignReturnCompulsory: json['isForeignReturnCompulsory'],
      minimumDaysRequired: json['minimumDaysRequired'],
      certificateRequiredId: json['certificateRequiredId'],
      minimumCTC: convertToDouble(json['minimumCTC']),
      maximumCTC: convertToDouble(json['maximumCTC']),
      isOTIncluded: json['isOTIncluded'] ?? false,
      maxOTHours: json['maxOTHours'],
      bonus: convertToDouble(json['bonus']),
      countryId: json['countryId'],
      minAgeLimit: int.parse(json['minAgeLimit'] ?? 0),
      maxAgeLimit: int.parse(json['maxAgeLimit'] ?? 0),
      noOfPosts: int.parse(json['noOfPosts'] ?? 0),
      salaryCurrency: salaryConverter(json['salaryCurrency']),
      contractPeriodInMonths: json['contractPeriodInMonths'],
      createdBy: json['createdBy'] ?? 0,
      updatedBy: json['updatedBy'],
      createdOn: Util.convertToDateTime(json['createdOn']),
      updatedOn: Util.convertToDateTime(json['updatedOn']),
      dailyWorkingHours: json['dailyWorkingHours'] ?? 0,
      visaType: json['visaType'] ?? 0,
      isMedicalInsuranceProvide: json['isMedicalInsuranceProvide'] ?? false,
      overseasExperience: json['overseasExperience'],
      localExperience: json['localExperience'],
      roleId: json['roleId'],
      profileImage: json['profileImage'],
      fullName: json['fullName'],
      jobTypeName: json['jobTypeName'],
      countryName: json['countryName'],
      currencyName: json['currencyName'],
      jobAppliedOn: Util.toDateTime(json['jobAppliedOn']),
      jobSavedOn: Util.toDateTime(json['jobSavedOn']),
      isMon: json['isMon'] ?? false,
      isTue: json['isTue'] ?? false,
      isThu: json['isThu'] ?? false,
      isWed: json['isWed'] ?? false,
      isFri: json['isFri'] ?? false,
      isSat: json['isSat'] ?? false,
      isSun: json['isSun'] ?? false,
    );
  }
}
