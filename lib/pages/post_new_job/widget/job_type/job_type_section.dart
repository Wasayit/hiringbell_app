import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/pages/common/dashed_container/bt_dashed_container.dart';
import 'package:hiringbell/pages/common/search_field/search_field.dart';
import 'package:hiringbell/pages/post_new_job/post_new_job_controller.dart';
import 'package:hiringbell/utilities/Util.dart';

class JobTypeSection extends GetView<PostNewJobController> {
  const JobTypeSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: Util.getPagePadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select job type",
                style: Util.getLabelHeaderStyle(),
              ),
              SearchField.iconSearch(
                searchUrl: "core/filter/getJobType",
                searchIcon: const Icon(Icons.add),
                onSelected: controller.handleSelectedJobType,
                ratio: 1,
              ),
            ],
          ),
          const SizedBox(
            height: Constants.contentVSpace,
          ),
          Obx(
            () => controller.jobTypeName.value == ""
                ? BtDashedContainer(
                    content: "Add type of the job for the current post",
                    child: SearchField.buttonSearch(
                      buttonText: "Add job type",
                      searchUrl: "core/filter/getJobType",
                      onSelected: controller.handleSelectedJobType,
                      ratio: 1,
                    ),
                  )
                : ListTile(
                    leading: const Icon(Icons.flag),
                    title: Text("${controller.jobTypeName}"),
                    subtitle:
                        const Text("Above is the job location for your post"),
                  ),
          ),
          const SizedBox(
            height: Constants.contentVSpace * 2,
          ),
        ],
      ),
    );
  }
}
