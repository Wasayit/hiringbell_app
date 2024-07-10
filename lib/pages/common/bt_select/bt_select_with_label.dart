import 'package:flutter/material.dart';
import 'package:hiringbell/pages/common/bt_select/bt_select.dart';
import 'package:hiringbell/pages/common/imulti_select/imulti_select_dropdown.dart';

class BtSelectWithLabel<T> extends StatelessWidget {
  final String label;
  final String? hintText;
  final List<T> items;
  final void Function(T)? onChanged;
  final IMultiSelectDropdownDecoration? decoration;
  final bool Function(T)? initSelectionCriteria;
  final String? Function(T?)? validator;
  final bool isEmptyValidation;
  final String? emptyMessage;

  const BtSelectWithLabel({
    super.key,
    this.hintText,
    required this.items,
    this.onChanged,
    this.initSelectionCriteria,
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
        BtSelect(
          hintText: hintText ?? "Select $label",
          items: items,
          initSelectionCriteria: initSelectionCriteria,
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
