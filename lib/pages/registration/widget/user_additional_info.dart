import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/common/bt_select/bt_select_with_label.dart';
import 'package:hiringbell/pages/common/bt_text_form_field/bt_text_form_field_with_label.dart';
import 'package:hiringbell/pages/create_job/widget/form_card.dart';
import 'package:hiringbell/pages/registration/client_registration_controller.dart';

class UserAdditionalInfo extends GetView<ClientRegistrationController> {
  const UserAdditionalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: "Additional Information",
      children: [
        Obx(
          () => Column(
            children: [
              SwitchListTile(
                value: controller.isEducated.value,
                activeColor: Colors.blueAccent,
                title: const Text('Is Educated'),
                onChanged: (value) {
                  controller.isEducated.value = value;
                  if (!value) controller.user.educationId = null;
                },
              ),
              if (controller.isEducated.value)
                BtSelectWithLabel(
                  label: "Highest Education",
                  items: controller.listEducation,
                  initSelectionCriteria: (c) =>
                      c.educationId == controller.user.educationId,
                  onChanged: (status) {
                    controller.user.educationId = status.educationId;
                  },
                )
            ],
          ),
        ),
        BtSelectWithLabel(
          label: "Current Employment Status",
          items: controller.listYesNo,
          initSelectionCriteria: (c) =>
              c.value == controller.user.currentEmploymentStatus,
          onChanged: (status) {
            controller.user.currentEmploymentStatus = status.value;
          },
        ),
        BtSelectWithLabel(
          label: "Local Work Experience",
          items: controller.listExperience,
          initSelectionCriteria: (c) => c == controller.user.localExperience,
          onChanged: (exp) {
            controller.user.localExperience = exp;
          },
        ),
        BtSelectWithLabel(
          label: "Gulf Work Experience",
          items: controller.listExperience,
          initSelectionCriteria: (c) => c == controller.user.overseasExperience,
          onChanged: (exp) {
            controller.user.overseasExperience = exp;
          },
        ),
      ],
    );
  }
}
