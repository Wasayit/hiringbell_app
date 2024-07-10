import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/models/experience.dart';
import 'package:hiringbell/pages/common/bt_divider/bt_divider.dart';
import 'package:hiringbell/pages/common/dashed_container/bt_dashed_container.dart';
import 'package:hiringbell/pages/common/list_tile/bt_list_tile.dart';
import 'package:hiringbell/pages/profile/profile_controller.dart';
import 'package:hiringbell/pages/profile/widget/experience/manage_experience.dart';

class WorkExperience extends GetView<ProfileController> {
  const WorkExperience({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(Constants.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Experience",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Constants.fontSize * 1.5,
                    ),
                  ),
                  if (controller.experienceFlag.value)
                    Wrap(
                      children: [
                        IconButton(
                          onPressed: () {
                            controller.addManageExperience();
                          },
                          icon: const Icon(Icons.add),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {
                            controller.loadManageExperience();
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BtListTile(
                left: const Icon(
                  Icons.leaderboard,
                  color: Colors.orange,
                  size: 60,
                ),
                right: !controller.experienceFlag.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Write something about your experience",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Constants.fontSize * 1.3,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          BtDashedContainer(
                            content:
                                "Add your work experience share your detail",
                            child: ElevatedButton(
                              onPressed: () {
                                controller.addManageExperience();
                              },
                              child: const Text("Click to Add"),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            controller.profileDetail!.experience!.roleName!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Constants.fontSize * 1.3,
                            ),
                          ),
                          Wrap(
                            children: [
                              Text(
                                controller
                                    .profileDetail!.experience!.companyName!,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("Full-time"),
                            ],
                          ),
                          Text(
                              "From: ${controller.profileDetail!.experience!.doj} to ${controller.profileDetail!.experience!.dol}"),
                          const SizedBox(
                            height: Constants.contentVSpace,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.flag,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                controller
                                    .profileDetail!.experience!.countryName!,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: Constants.contentVSpace,
                          ),
                          const SizedBox(
                            width: Constants.contentVSpace,
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Wrap(
                              children: [
                                Text(
                                  controller.profileDetail!.experience!
                                      .roleDescription,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
              ),
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
