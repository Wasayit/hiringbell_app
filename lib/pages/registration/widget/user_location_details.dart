import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/common/bt_select/bt_select_with_label.dart';
import 'package:hiringbell/pages/common/bt_text_form_field/bt_text_form_field_with_label.dart';
import 'package:hiringbell/pages/create_job/widget/form_card.dart';
import 'package:hiringbell/pages/registration/client_registration_controller.dart';

class UserLocationDetails extends GetView<ClientRegistrationController> {
  const UserLocationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: "Location Details",
      children: [
        BTTextFormFieldWithLabel(
          keyboardType: TextInputType.number,
          label: "Pincode",
          initialValue: controller.user.pinCode.toString(),
          onChanged: (value) {
            controller.user.pinCode = int.parse(value);
          },
        ),
        BtSelectWithLabel(
          label: "Country",
          items: controller.listCountry,
          initSelectionCriteria: (c) =>
              c.id.toString() == controller.user.country,
          onChanged: (country) {
            controller.user.country = country.id.toString();
          },
        ),
        BtSelectWithLabel(
          label: "State",
          items: controller.listStates,
          initSelectionCriteria: (c) =>
              c.value.toString() == controller.user.state,
          onChanged: (state) {
            controller.user.state = state.value.toString();
          },
        ),
        BtSelectWithLabel(
          label: "City",
          items: controller.listCities,
          initSelectionCriteria: (c) =>
              c.value.toString() == controller.user.city,
          onChanged: (city) {
            controller.user.city = city.value.toString();
          },
        ),
      ],
    );
  }
}
