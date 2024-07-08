import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/pages/post_new_job/post_new_job_controller.dart';
import 'package:hiringbell/utilities/Util.dart';

class BasicInfoSection extends GetView<PostNewJobController> {
  const BasicInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Util.getPagePadding(),
      child: Column(
        children: [
          const Text(
            "Post Basic Information",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: Constants.fontSize * 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .85,
                  child: TextFormField(
                    key: controller.titleFieldKey,
                    decoration: Util.getTextFieldDecoration(
                      placeholder: 'Job title',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        controller.util.showToast("Job title is required",
                            type: Constants.fail);
                        Scrollable.ensureVisible(
                          controller.titleFieldKey.currentContext!,
                          duration: const Duration(microseconds: 998),
                          curve: Curves.easeInOut,
                        );
                        return "Job title is required";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      controller.jobPost.shortDescription = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .85,
                  child: TextFormField(
                    maxLines: null,
                    key: controller.descriptionFieldKey,
                    keyboardType: TextInputType.multiline,
                    // Allows multi-line input
                    decoration: Util.getTextFieldDecoration(
                      placeholder: 'Enter job description',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        controller.util.showToast("Job description is required",
                            type: Constants.fail);
                        Scrollable.ensureVisible(
                          controller.descriptionFieldKey.currentContext!,
                          duration: const Duration(microseconds: 998),
                          curve: Curves.easeInOut,
                        );
                        return "Job description is required";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      controller.jobPost.completeDescription = value;
                    },
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
