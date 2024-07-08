import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/pages/post_new_job/post_new_job_controller.dart';
import 'package:hiringbell/utilities/Util.dart';

class VacancySection extends GetView<PostNewJobController> {
  VacancySection({super.key});

  final List<int> list = List.generate(50, (x) => x + 1);

  @override
  Widget build(BuildContext context) {
    var dropdownValue = list.first;
    return Padding(
      padding: Util.getPagePadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Job vacancies*",
            style: Util.getLabelHeaderStyle(),
          ),
          const Text(
            "Add number of open position for this post",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .85,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  key: controller.vacancyFieldKey,
                  decoration: Util.getTextFieldDecoration(
                    placeholder: 'Job vacancies',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      controller.util.showToast("Job vacancy is required",
                          type: Constants.fail);
                      return "Job vacancy is required";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.jobPost.noOfPosts = int.parse(value);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
