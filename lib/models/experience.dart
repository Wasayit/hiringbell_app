import 'package:hiringbell/models/constants.dart';
import 'package:intl/intl.dart';

class Experience {
  int experienceId = 0;
  int userId = 0;
  String? roleName = Constants.empty;
  String? companyName = Constants.empty;
  String? doj;
  String? dol;
  String? countryName = Constants.empty;
  String roleDescription = Constants.empty;

  Experience.noArgs();

  Experience({
    required experienceId,
    required userId,
    required roleName,
    required companyName,
    required doj,
    required dol,
    required countryName,
    required this.roleDescription,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    var experience = Experience.noArgs();
    var doj = DateFormat("yyyy-MM-dd").parse(json["doj"]);
    var dol = DateFormat("yyyy-MM-dd").parse(json["dol"]);

    experience.companyName = json["companyName"];
    experience.countryName = json["countryName"];
    experience.doj = DateFormat("dd MMM, yyy").format(doj);
    experience.dol = DateFormat("dd MMM, yyy").format(dol);
    experience.experienceId = json["experienceId"];
    experience.roleName = json["roleName"];
    experience.userId = json["userId"];
    experience.roleDescription = json["roleDescription"] ?? "";
    return experience;
  }
}
