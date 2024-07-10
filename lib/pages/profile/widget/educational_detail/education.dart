import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/pages/common/bt_divider/bt_divider.dart';
import 'package:hiringbell/pages/common/dashed_container/bt_dashed_container.dart';
import 'package:hiringbell/pages/common/list_tile/bt_list_tile.dart';
import 'package:hiringbell/pages/profile/profile_controller.dart';
import 'package:hiringbell/pages/profile/widget/educational_detail/manage_education.dart';

class Education extends GetView<ProfileController> {
  const Education({super.key});

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
                    "Education",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Constants.fontSize * 1.5,
                    ),
                  ),
                  if (controller.profileDetail!.education != null)
                    Wrap(
                      children: [
                        InkWell(
                          onTap: controller.addEducation,
                            child: const Icon(Icons.add),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: controller.editEducation,
                          child: const Icon(Icons.edit),
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
                  Icons.account_balance,
                  color: Colors.red,
                  size: 60,
                ),
                right: controller.profileDetail!.education == null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Add your educational qualification",
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
                                "Add your educational qualification detail",
                            child: ElevatedButton(
                              onPressed: controller.addEducation,
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
                            controller.profileDetail!.education!.collageOrSchoolName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Constants.fontSize * 1.3,
                            ),
                          ),
                          Text(
                            controller.profileDetail!.education!.educationName!),
                          Text("${controller.profileDetail!.education!.yearOfPassout - controller.profileDetail!.education!.duration} - ${controller.profileDetail!.education!.yearOfPassout}"),
                          const SizedBox(
                            height: Constants.contentVSpace,
                          ),
                          Wrap(
                            children: [
                              const Icon(Icons.flag),
                              const SizedBox(
                                width: Constants.contentHSpace,
                              ),
                              Text(controller.profileDetail!.education!.country),
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
