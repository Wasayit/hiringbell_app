import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/models/dropdown_items.dart';
import 'package:hiringbell/models/education.dart';
import 'package:hiringbell/pages/common/child_layout/child_layout.dart';
import 'package:hiringbell/pages/common/dropdown/bt_dropdown.dart';
import 'package:hiringbell/pages/common/search_field/search_field.dart';
import 'package:hiringbell/pages/profile/profile_controller.dart';
import 'package:hiringbell/utilities/Util.dart';

class ManageEducation extends GetView<ProfileController> {
  final Education education;
  final bool editMode;

  const ManageEducation({
    super.key,
    required this.education,
    this.editMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChildLayout(
      title: "Manage educational detail",
      child: SingleChildScrollView(
        child: Form(
          key: controller.educationForm,
          child: Column(
            children: [
              Padding(
                padding: Util.getPagePadding(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Add or edit your educational detail",
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
                        "Use this screen add your academic detail, "
                        "e.g. your 10th, Graduation etc.",
                        style: TextStyle(
                          fontSize: Constants.fontSize * .85,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BtDropdown.styled(
                      onChanged: (item) {
                        controller.educationTypeId = item.value;
                      },
                      items: [
                        DropdownItems(value: 1, text: "10th standard"),
                        DropdownItems(value: 2, text: "12th standard"),
                        DropdownItems(value: 3, text: "Graduation"),
                      ],
                      selectedItemId: controller.profileDetail!.education!.educationTypeId,
                      label: "Education Type",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: null,
                      controller: controller.collegeSchollController,
                      decoration: Util.getTextFieldDecoration(
                        placeholder: 'College/School Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "College/School is required";
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
                      controller: controller.universityBoardController,
                      decoration: Util.getTextFieldDecoration(
                        placeholder: 'University/Board Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "University Board is required";
                        }
                        return null;
                      },
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                controller.onSelectPassOutYear();
                              },
                              child: TextFormField(
                                maxLines: null,
                                enabled: false,
                                controller: controller.doaController.value,
                                decoration: Util.getTextFieldDecoration(
                                  placeholder: 'Pass out year',
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
                                    return "Pass out is required";
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BtDropdown.styled(
                      onChanged: (item) {
                        controller.duration = item.value;
                      },
                      items: [
                        DropdownItems(value: 1, text: "1 year"),
                        DropdownItems(value: 2, text: "2 years"),
                        DropdownItems(value: 3, text: "3 years"),
                        DropdownItems(value: 4, text: "4 years")
                      ],
                      selectedItemId: controller.profileDetail!.education!.duration,
                      label: "Duration",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Education country",
                                style: Util.getLabelHeaderStyle(),
                              ),
                              SearchField.iconSearch(
                                searchUrl: "core/filter/getCountries",
                                searchIcon: const Icon(Icons.add),
                                onSelected:
                                    controller.handledUniversityBoardCountry,
                                ratio: 1,
                              ),
                            ],
                          ),
                          if (controller.universityBoardCountry.value.isEmpty)
                            const Text(
                              "Click + icon add your education country",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: Constants.fontSize * .9,
                              ),
                            )
                          else
                            ListTile(
                              leading: const Icon(Icons.flag),
                              title:
                                  Text(controller.universityBoardCountry.value),
                              subtitle: const Text(
                                  "Above is your selected work location"),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: Constants.contentVSpace * 2,
                    ),
                    Obx(
                      () => Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (editMode &&
                                controller.profileDetail!.experience!
                                        .experienceId ==
                                    0) {
                              controller.util.showToast(
                                  "Experience page is not loaded correctly.");
                              return;
                            }

                            if (editMode) {
                              controller.addEducationDetail();
                            } else {
                              controller.updateEducationDetail();
                            }
                          },
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
