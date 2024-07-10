import 'package:flutter/material.dart';
import 'package:hiringbell/pages/common/bt_select/bt_multi_select.dart';
import 'package:hiringbell/pages/common/imulti_select/imulti_select_dropdown.dart';

class BtMultiSelectWithLabel<T> extends StatelessWidget {
  final String label;
  final String? hintText;
  final List<T> items;
  final void Function(List<T>)? onChanged;
  final IMultiSelectDropdownDecoration? decoration;
  final List<T>? initialItems;
  final String? Function(List<T>)? validator;
  final bool isEmptyValidation;
  final String? emptyMessage;

  const BtMultiSelectWithLabel({
    super.key,
    this.hintText,
    required this.items,
    this.onChanged,
    this.initialItems,
    this.decoration,
    this.validator,
    this.isEmptyValidation = true,
    required this.label,
    this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        BtMultiSelect(
          hintText: hintText ?? "Select $label",
          items: items,
          initialItems: initialItems,
          onChanged: onChanged,
          validator: validator,
          isEmptyValidation: isEmptyValidation,
          emptyMessage: emptyMessage ?? "Please select $label",
        ),
        const SizedBox(height: 2)
      ],
    );
  }
}
