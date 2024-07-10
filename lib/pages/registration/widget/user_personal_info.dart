import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/common/bt_date_picker/bt_date_picker_with_label.dart';
import 'package:hiringbell/pages/common/bt_select/bt_select_with_label.dart';
import 'package:hiringbell/pages/common/bt_text_form_field/bt_text_form_field_with_label.dart';
import 'package:hiringbell/pages/create_job/widget/form_card.dart';
import 'package:hiringbell/pages/registration/client_registration_controller.dart';

class UserPersonalInfo extends GetView<ClientRegistrationController> {
  const UserPersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: "Personal Information",
      children: [
        BTTextFormFieldWithLabel(
          label: "Full Name",
          initialValue: controller.user.firstName,
          onChanged: (value) {
            controller.user.firstName = value;
          },
        ),
        BtDatePickerWithLabel(
            label: 'Date of Birth',
            initialValue: controller.user.dateOfBirth,
            firstDate: DateTime(2000),
            lastDate: DateTime(2020),
            onChanged: (value) {
              controller.user.dateOfBirth = value;
            }),
        BTTextFormFieldWithLabel(
          keyboardType: TextInputType.phone,
          label: "Mobile Number",
          initialValue: controller.user.mobile,
          onChanged: (value) {
            controller.user.mobile = value;
          },
        ),
        BTTextFormFieldWithLabel(
          keyboardType: TextInputType.emailAddress,
          label: "Email Address",
          initialValue: controller.user.email,
          onChanged: (value) {
            controller.user.email = value;
          },
        ),
        BTTextFormFieldWithLabel(
          keyboardType: TextInputType.emailAddress,
          label: "Password",
          initialValue: controller.user.password,
          onChanged: (value) {
            controller.user.password = value;
          },
        ),
        BTTextFormFieldWithLabel(
          isEmptyValidation: false,
          label: "Mother's Name",
          initialValue: controller.user.motherName,
          onChanged: (value) {
            controller.user.motherName = value;
          },
        ),
        BTTextFormFieldWithLabel(
          isEmptyValidation: false,
          label: "Father's Name",
          initialValue: controller.user.fatherName,
          onChanged: (value) {
            controller.user.fatherName = value;
          },
        ),
        BtSelectWithLabel(
          label: "Gender",
          items: controller.listGender,
          initSelectionCriteria: (c) => c.value == controller.user.gender,
          onChanged: (gender) {
            controller.user.gender = gender.value;
          },
        ),
        BtSelectWithLabel(
          label: "Marital Status",
          items: controller.listYesNo,
          initSelectionCriteria: (c) =>
              c.value == controller.user.maritalStatus,
          onChanged: (status) {
            controller.user.maritalStatus = status.value;
          },
        ),
        BtSelectWithLabel(
          label: "Religion",
          items: controller.listReligion,
          initSelectionCriteria: (c) =>
              c.religionId == controller.user.religionId,
          onChanged: (religion) {
            controller.user.religionId = religion.religionId;
          },
        ),
        BTTextFormFieldWithLabel(
          label: "Full Address",
          initialValue: controller.user.address,
          onChanged: (value) {
            controller.user.address = value;
          },
        ),
      ],
    );
  }
}
