import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/pages/common/child_layout/child_layout.dart';
import 'package:hiringbell/pages/common/dashed_container/bt_dashed_container.dart';
import 'package:hiringbell/pages/common/search_field/search_field.dart';
import 'package:hiringbell/pages/profile/profile_controller.dart';
import 'package:hiringbell/utilities/Util.dart';

class UserIntroDetail extends GetView<ProfileController> {
  const UserIntroDetail({super.key});

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
                            fontSize: Constants.fontSize * .85,
                            color: Colors.grey),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controller.jobTitleController,
                      decoration: Util.getTextFieldDecoration(
                        placeholder: 'Enter your work type',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          controller.util.showToast("Job title is required",
                              type: Constants.fail);
                          return "Job title is required";
                        }
                        return null;
                      },
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: Constants.contentVSpace * 2,
                    ),
                    const Text("Write few words about your work"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .85,
                          child: TextFormField(
                            maxLines: null,
                            controller: controller.jobShortDescController,
                            keyboardType: TextInputType.multiline,
                            // Allows multi-line input
                            decoration: Util.getTextFieldDecoration(
                              placeholder: 'Enter job description',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                controller.util.showToast(
                                    "Job short description is required",
                                    type: Constants.fail);
                                /*Scrollable.ensureVisible(
                              controller.descriptionFieldKey.currentContext!,
                              duration: const Duration(microseconds: 998),
                              curve: Curves.easeInOut,
                            );*/
                                return "Job description is required";
                              }
                              return null;
                            },
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Constants.contentVSpace * 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your present/last work location",
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
                              subtitle: const Text(
                                  "Above is the job location for your post"),
                            ),
                    ),
                    const SizedBox(
                      height: Constants.contentVSpace * 2,
                    ),
                    Obx(
                      () => Center(
                        child: ElevatedButton(
                          onPressed: controller.saveUserBasicInfo,
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
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
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
                                                .surface),
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
                                        "Update record",
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
