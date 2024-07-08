import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/pages/post_new_job/post_new_job_controller.dart';
import 'package:hiringbell/utilities/Util.dart';

class SalarySection extends GetView<PostNewJobController> {
  SalarySection({super.key});

  List<int> list = [];

  @override
  Widget build(BuildContext context) {
    list = controller.generateRandomNumber(range: 50);
    int dropdownValue = list.first;
    return Padding(
      padding: Util.getPagePadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Min - Max Salary*",
            style: Util.getLabelHeaderStyle(),
          ),
          const Text(
            "Set min and max expected salary i.e. CTC per annam",
            style: TextStyle(
              color: Colors.grey,
              fontSize: Constants.fontSize * .9,
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
                    keyboardType: TextInputType.number,
                    key: controller.minSalaryFieldKey,
                    decoration: Util.getTextFieldDecoration(
                      placeholder: 'Enter min salary',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        controller.util.showToast("Minimum salary is required",
                            type: Constants.fail);
                        Scrollable.ensureVisible(
                          controller.minSalaryFieldKey.currentContext!,
                          duration: const Duration(microseconds: 998),
                          curve: Curves.easeInOut,
                        );
                        return "Minimum salary is required";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        controller.jobPost.minimumCTC = double.parse(value);
                      }
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .85,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    key: controller.maxSalaryFieldKey,
                    decoration: Util.getTextFieldDecoration(
                      placeholder: 'Enter max salary',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        controller.util.showToast("Maximum salary is required",
                            type: Constants.fail);
                        Scrollable.ensureVisible(
                          controller.maxSalaryFieldKey.currentContext!,
                          duration: const Duration(microseconds: 998),
                          curve: Curves.easeInOut,
                        );
                        return "Maximum salary is required";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        controller.jobPost.maximumCTC = double.parse(value);
                      }
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
