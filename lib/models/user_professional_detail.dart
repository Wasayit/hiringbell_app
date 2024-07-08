import 'dart:convert';

import 'package:hiringbell/models/constants.dart';
import 'package:jiffy/jiffy.dart';

class UserProfessionalDetail {
  int userProfessionalDetailId = 0;
  int userId = 0;
  String? title = Constants.empty;
  String? shortDescription = Constants.empty;
  String? completeDescription = Constants.empty;
  String? presentWorkLocation = Constants.empty;

  UserProfessionalDetail();

  UserProfessionalDetail.fromUser({
    required this.userProfessionalDetailId,
    required this.userId,
    required this.title,
    required this.shortDescription,
    required this.completeDescription,
    required this.presentWorkLocation,
  });

  factory UserProfessionalDetail.fromJson(dynamic json) {
    return UserProfessionalDetail.fromUser(
      userProfessionalDetailId: json["userProfessionalDetailId"],
      userId: json["userId"],
      title: json["title"],
      shortDescription: json["shortDescription"],
      completeDescription: json["completeDescription"],
      presentWorkLocation: json["presentWorkLocation"],
    );
  }
}
