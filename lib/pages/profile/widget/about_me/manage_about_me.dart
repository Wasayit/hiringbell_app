import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/pages/common/child_layout/child_layout.dart';
import 'package:hiringbell/pages/profile/profile_controller.dart';
import 'package:hiringbell/utilities/Util.dart';

class ManageAboutMe extends GetView<ProfileController> {
  const ManageAboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return ChildLayout(
      title: "User basic detail",
      child: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Padding(
                padding: Util.getPagePadding(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Write few words about yourself",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: Constants.fontSize * 1.2,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: const Text(
                        "Craft a brief and professional self-introduction highlighting your work, "
                        "skills, and strengths to effectively communicate your capabilities to others.",
                        style: TextStyle(
                            fontSize: Constants.fontSize * .85,
                            color: Colors.grey),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: null,
                      controller: controller.aboutMeController,
                      keyboardType: TextInputType.multiline,
                      // Allows multi-line input
                      decoration: Util.getTextFieldDecoration(
                        placeholder: 'Write your text here...',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          controller.util.showToast(
                              "Job short description is required",
                              type: Constants.fail);
                          return "Job description is required";
                        }
                        return null;
                      },
                      onChanged: (value) {},
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Maximum 500 charters",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Constants.contentVSpace * 2,
                    ),
                    Obx(
                      () => Center(
                        child: ElevatedButton(
                          onPressed: controller.updateAboutMeDetail,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          child: controller.isSubmitted.value
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width * .4,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "Updating...",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  width: MediaQuery.of(context).size.width * .4,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.edit_note,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Update detail",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
