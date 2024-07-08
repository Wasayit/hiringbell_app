import 'package:hiringbell/models/education.dart';
import 'package:hiringbell/models/experience.dart';
import 'package:hiringbell/models/interests.dart';
import 'package:hiringbell/models/skills.dart';
import 'package:hiringbell/models/user.dart';
import 'package:hiringbell/models/user_professional_detail.dart';

class ProfileDetail {
  User? userDetail;
  UserProfessionalDetail? userProfessionalDetail;
  Experience? experience;
  Education? education;
  Skills? skills;
  Interests? interests;

  ProfileDetail({
    required this.userDetail,
    required this.experience,
    required this.education,
    required this.skills,
    required this.interests,
  });

  ProfileDetail.noArgument();
}
