import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/pages/common/bt_divider/bt_divider.dart';
import 'package:hiringbell/pages/common/dashed_container/bt_dashed_container.dart';
import 'package:hiringbell/pages/common/list_tile/bt_list_tile.dart';
import 'package:hiringbell/pages/profile/profile_controller.dart';
import 'package:hiringbell/pages/profile/widget/experience/manage_experience.dart';

class Experience extends GetView<ProfileController> {
  const Experience({super.key});

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
                    const Wrap(
                      children: [
                        Icon(Icons.add),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.edit),
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
                                Get.to(const ManageExperience());
                              },
                              child: const Text("Click to Add"),
                            ),
                          ),
                        ],
                      )
                    : const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Solution Architect",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Constants.fontSize * 1.3,
                            ),
                          ),
                          Wrap(
                            children: [
                              Text("BottomHalf"),
                              Text("Full-time"),
                            ],
                          ),
                          Text("Mar 2020 - Present. 4 yrs 5 months"),
                          Text("Asansol, West Bengal, India - ASN"),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: Constants.contentHSpace,
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Wrap(
                              children: [
                                Text(
                                  "Solution Architecture, good knowledge in Java, C# and AI using python and c++",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Wrap(
                            children: [
                              Icon(Icons.diamond),
                              SizedBox(
                                width: Constants.contentHSpace,
                              ),
                              Text("Solution Architecture, "),
                              Text("Spring boot and +1 skills")
                            ],
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
