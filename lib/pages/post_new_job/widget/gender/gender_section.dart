import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/common/search_field/search_field.dart';
import 'package:hiringbell/pages/post_new_job/post_new_job_controller.dart';
import 'package:hiringbell/pages/post_new_job/widget/gender/gender_sheet.dart';
import 'package:hiringbell/utilities/Util.dart';

class GenderSection extends GetView<PostNewJobController> {
  const GenderSection({super.key});

  String getGenderName(int genderId) {
    switch (genderId) {
      case 1:
        return "Male";
      case 2:
        return "Female";
      default:
        return "Any Gender";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Util.getPagePadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gender for Job*",
            style: Util.getLabelHeaderStyle(),
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (controller.genderId.value == 0)
                  const Text("Add gender")
                else
                  Text(getGenderName(controller.genderId.value)),
                SearchField.iconCustom(
                  searchIcon: const Icon(
                    Icons.edit,
                    color: Colors.grey,
                    size: 16,
                  ),
                  ratio: .35,
                  child: GenderSheet(
                    genderId: controller.jobPost.gender,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
