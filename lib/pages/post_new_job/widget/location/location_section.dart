import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/pages/common/dashed_container/bt_dashed_container.dart';
import 'package:hiringbell/pages/common/search_field/search_field.dart';
import 'package:hiringbell/pages/post_new_job/post_new_job_controller.dart';
import 'package:hiringbell/utilities/Util.dart';

class LocationSection extends GetView<PostNewJobController> {
  const LocationSection({super.key});

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
                "Select job location",
                style: Util.getLabelHeaderStyle(),
              ),
              SearchField.iconSearch(
                searchUrl: "core/filter/getCountries",
                searchIcon: const Icon(Icons.add),
                onSelected: controller.handleSelectedCountry,
                ratio: 1,
              ),
            ],
          ),
          const SizedBox(
            height: Constants.contentVSpace,
          ),
          Obx(
            () => controller.countryName.value == ""
                ? BtDashedContainer(
                    content: "Please add country for the current job",
                    child: SearchField.buttonSearch(
                      buttonText: "Add countries",
                      searchUrl: "core/filter/getCountries",
                      onSelected: controller.handleSelectedCountry,
                      ratio: 1,
                    ),
                  )
                : ListTile(
                    leading: const Icon(Icons.flag),
                    title: Text("${controller.countryName}"),
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
