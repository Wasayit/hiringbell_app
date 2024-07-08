import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/pages/common/child_layout/child_layout.dart';
import 'package:hiringbell/pages/common/textarea/bt_textarea.dart';
import 'package:hiringbell/pages/profile/profile_controller.dart';
import 'package:hiringbell/utilities/Util.dart';

class ManageExperience extends GetView<ProfileController> {
  const ManageExperience({super.key});

  @override
  Widget build(BuildContext context) {
    return ChildLayout(
      title: "Manage experience",
      child: SingleChildScrollView(
        child: Form(
          key: controller.experienceFormKey,
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
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: null,
                      controller: controller.roleNameController,
                      decoration: Util.getTextFieldDecoration(
                        placeholder: 'Role name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          controller.util.showToast("Role name is required",
                              type: Constants.fail);
                          return "Role name is required";
                        }
                        return null;
                      },
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: null,
                      controller: controller.companyNameController,
                      decoration: Util.getTextFieldDecoration(
                        placeholder: 'Company name',
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
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              debugPrint("working....");
                              controller.dojController.text = "12 July, 2024";
                            },
                            child: TextFormField(
                              maxLines: null,
                              enabled: false,
                              controller: controller.dojController,
                              decoration: Util.getTextFieldDecoration(
                                placeholder: 'Date of joining',
                                trailingIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.calendar_today,
                                    size: 16,
                                  ),
                                ),
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
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              debugPrint("working....");
                            },
                            child: TextFormField(
                              maxLines: null,
                              enabled: false,
                              controller: controller.dolController,
                              decoration: Util.getTextFieldDecoration(
                                placeholder: 'Date of leaving',
                                trailingIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.calendar_today,
                                    size: 16,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  controller.util.showToast(
                                    "Job short description is required",
                                    type: Constants.fail,
                                  );
                                  return "Job description is required";
                                }
                                return null;
                              },
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BtTextarea(
                      textController: controller.jobDescController,
                    ),
                    const SizedBox(
                      height: Constants.contentVSpace * 2,
                    ),
                    Obx(
                      () => Center(
                        child: ElevatedButton(
                          onPressed: controller.updateExperience,
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
