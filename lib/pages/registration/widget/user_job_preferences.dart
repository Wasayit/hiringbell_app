import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/common/bt_date_picker/bt_date_picker_with_label.dart';
import 'package:hiringbell/pages/common/bt_select/bt_multi_select_with_label.dart';
import 'package:hiringbell/pages/create_job/widget/form_card.dart';
import 'package:hiringbell/pages/registration/client_registration_controller.dart';

class UserJobPreferences extends GetView<ClientRegistrationController> {
  const UserJobPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: "Job Preferences",
      children: [
        BtMultiSelectWithLabel(
          label: "Key Skills",
          items: controller.listJobType,
          initialItems: controller.listJobType
              .where((c) =>
                  controller.user.listJobTypeIds?.contains(c.jobTypeId) ??
                  false)
              .toList(),
          onChanged: (skillType) {
            controller.user.listJobTypeIds =
                skillType.map((c) => c.jobTypeId).toList();
          },
        ),
        BtMultiSelectWithLabel(
          label: "Preferred Job Locations",
          items: controller.listCountry,
          initialItems: controller.listCountry
              .where((c) =>
                  controller.user.listJobLocationIds?.contains(c.id) ?? false)
              .toList(),
          onChanged: (country) {
            controller.user.listJobLocationIds =
                country.map((c) => c.id).toList();
          },
        ),
        BtDatePickerWithLabel(
            label: 'Availability Date',
            initialValue: controller.user.availabilityDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 200)),
            onChanged: (value) {
              controller.user.availabilityDate = value;
            }),
      ],
    );
  }
}
