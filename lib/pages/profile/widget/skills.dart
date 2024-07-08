import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/pages/common/bt_divider/bt_divider.dart';
import 'package:hiringbell/pages/common/dashed_container/bt_dashed_container.dart';
import 'package:hiringbell/pages/common/list_tile/bt_list_tile.dart';
import 'package:hiringbell/pages/profile/profile_controller.dart';

class Skills extends GetView<ProfileController> {
  const Skills({super.key});

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
                    "Skills",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Constants.fontSize * 1.5,
                    ),
                  ),
                  if (controller.profileDetail!.skills != null)
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
                  Icons.timeline,
                  color: Colors.blue,
                  size: 60,
                ),
                right: controller.profileDetail!.skills == null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Add your skills",
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
                                "Add your skill i.e. Content write, Business analyst",
                            child: ElevatedButton(
                              onPressed: (){},
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
                            "Biju Patnayak University of Technology, Odisha",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Constants.fontSize * 1.3,
                            ),
                          ),
                          Text(
                              "BTech - Bachelor of Technology, Computer Science"),
                          Text("2006 - 2013"),
                          SizedBox(
                            height: Constants.contentVSpace,
                          ),
                          Wrap(
                            children: [
                              Icon(Icons.diamond),
                              SizedBox(
                                width: Constants.contentHSpace,
                              ),
                              Text(
                                  "Solution Architecture and Artificial Intelligence (AI)"),
                            ],
                          ),
                        ],
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
