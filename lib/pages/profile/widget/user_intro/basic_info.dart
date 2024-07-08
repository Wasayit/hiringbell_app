import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/pages/common/bt_box/bt_box.dart';
import 'package:hiringbell/pages/common/bt_circular_container/bt_circular_container.dart';
import 'package:hiringbell/pages/common/button/bt_button.dart';
import 'package:hiringbell/pages/common/search_field/search_field.dart';
import 'package:hiringbell/pages/profile/profile_controller.dart';
import 'package:hiringbell/pages/profile/widget/intro_sheet.dart';
import 'package:hiringbell/pages/profile/widget/user_intro/user_intro_detail.dart';

import '../../../common/bt_divider/bt_divider.dart';

class BasicInfo extends GetView<ProfileController> {
  const BasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            const SizedBox(
              width: double.infinity,
              height: 240,
            ),
            Container(
              width: double.infinity,
              height: 150,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/profile-dg-1.jpg'),
                      fit: BoxFit.cover)),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: BtCircularContainer(
                radius: 140,
                child: const Text("IMG"),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 70,
              right: 0,
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade400,
                radius: 15,
                child: const Icon(
                  Icons.edit,
                  size: 14,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              children: [
                Text(
                  "${controller.profileDetail!.userDetail!.firstName} ${controller.profileDetail!.userDetail!.lastName}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (!controller.isBasicInfoIsReady.value)
                          const Text("Your role here")
                        else
                          Text(
                            controller.profileDetail!.userProfessionalDetail!
                                .title!,
                            style: const TextStyle(
                              fontSize: Constants.fontSize * 1.2,
                            ),
                          ),
                        IconButton(
                          icon: const Icon(
                            Icons.mode_edit_outline_outlined,
                          ),
                          onPressed: () {
                            Get.to(const UserIntroDetail());
                          },
                        ),
                      ],
                    ),
                    if (!controller.isBasicInfoIsReady.value)
                      const Text(
                        "Tell us more about your professional work so others can get to know you better.",
                        textAlign: TextAlign.center,
                      )
                    else
                      Text(
                        controller.profileDetail!.userProfessionalDetail!
                            .shortDescription!,
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (!controller.isBasicInfoIsReady.value)
                      const Text("Your current location")
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Current work location",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(controller
                                  .profileDetail!
                                  .userProfessionalDetail!
                                  .presentWorkLocation!),
                              const SizedBox(
                                width: 4,
                              ),
                              const Icon(
                                Icons.flag_outlined,
                                size: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Row(
            children: [
              BtButton(
                title: "Applied Jobs",
                onClick: () {},
                addHGap: 5,
                bgColor: Theme.of(context).colorScheme.primary,
                textColor: Colors.white,
                roundedValue: 50,
              ),
              BtButton(
                title: "Saved Jobs",
                onClick: () {},
                addHGap: 5,
                roundedValue: 50,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        BtDivider(
          space: 0,
          thickness: 6,
        ),
      ],
    );
  }
}
