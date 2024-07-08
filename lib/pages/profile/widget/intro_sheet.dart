import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/pages/common/button/bt_button.dart';
import 'package:hiringbell/pages/post_new_job/post_new_job_controller.dart';
import 'package:hiringbell/pages/profile/profile_controller.dart';
import 'package:hiringbell/utilities/Util.dart';

class IntroSheet extends StatefulWidget {
  const IntroSheet({
    super.key,
  });

  @override
  State<IntroSheet> createState() => _IntroSheetState();
}

class _IntroSheetState extends State<IntroSheet> {
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Write your designation & experience",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Constants.fontSize * 1.2,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: const Text(
            "You can write few work to describe your work title and experience. e.g. Civil Engineer 10+, "
            "Mechanical helper 2+ etc.",
            style: TextStyle(
                fontSize: Constants.fontSize * .85, color: Colors.grey),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: Util.getTextFieldDecoration(
            placeholder: 'Enter your work type',
          ),
          validator: (value) {
            if (value!.isEmpty) {
              controller.util
                  .showToast("Job title is required", type: Constants.fail);
              return "Job title is required";
            }
            return null;
          },
          onChanged: (value) {},
        ),
        const SizedBox(
          height: Constants.contentVSpace,
        ),
        Center(
          child: ElevatedButton(
            child: const Text("Add"),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
