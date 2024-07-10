import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/pages/common/bt_divider/bt_divider.dart';
import 'package:hiringbell/pages/common/dashed_container/bt_dashed_container.dart';
import 'package:hiringbell/pages/profile/profile_controller.dart';
import 'package:hiringbell/pages/profile/widget/about_me/manage_about_me.dart';

class AboutMe extends GetView<ProfileController> {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.pagePadding,
            vertical: Constants.pagePadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "About me",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Constants.fontSize * 1.5,
                    ),
                  ),
                  if (controller.aboutMeFlag.value)
                    IconButton(
                      onPressed: () async {
                        await Get.to(const ManageAboutMe())?.then(
                          (_) => {
                            if(!controller.isReady.value) {
                              controller.reloadPage()
                            }
                          },
                        );
                      },
                      icon: const Icon(
                        Constants.icon,
                        color: Colors.grey,
                        size: 18,
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: Constants.contentHSpace * 1.5,
              ),
              if (controller.aboutMeFlag.value)
                Text(
                  controller.profileDetail!.userProfessionalDetail!
                      .completeDescription!,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                )
              else
                BtDashedContainer(
                  content: "Add something your about self",
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(const ManageAboutMe());
                    },
                    child: const Text("Click to Add"),
                  ),
                )
            ],
          ),
        ),
        BtDivider(
          thickness: 14,
        ),
      ],
    );
  }
}
