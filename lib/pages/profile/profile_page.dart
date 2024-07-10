import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/common/child_layout/child_layout.dart';
import 'package:hiringbell/pages/profile/profile_controller.dart';
import 'package:hiringbell/pages/profile/widget/about_me/about_me.dart';
import 'package:hiringbell/pages/profile/widget/analytics_reports.dart';
import 'package:hiringbell/pages/profile/widget/user_intro/basic_info.dart';
import 'package:hiringbell/pages/profile/widget/educational_detail/education.dart';
import 'package:hiringbell/pages/profile/widget/experience/work_experience.dart';
import 'package:hiringbell/pages/profile/widget/interests.dart';
import 'package:hiringbell/pages/profile/widget/skills.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var controller = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.loadProfilePage();
    controller.setContext(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if(!didPop) {
          debugPrint("Loaded -------------------------------------");
          Navigator.of(context).pop();
        }
      },
      child: RefreshIndicator(
        onRefresh: controller.reloadPage,
        child: Obx(
          () => ChildLayout(
            title: "Profile",
            child: controller.isReady.value
                ? ListView(
                    children: const [
                      BasicInfo(),
                      AnalyticsReports(),
                      AboutMe(),
                      WorkExperience(),
                      Education(),
                      Skills(),
                      Interests(),
                    ],
                  )
                : const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
