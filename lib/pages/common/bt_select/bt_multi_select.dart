import 'package:flutter/material.dart';

import '../imulti_select/imulti_select_dropdown.dart';
// For firstWhereOrNull

class BtMultiSelect<T> extends StatelessWidget {
  final String hintText;
  final List<T> items;
  final void Function(List<T>)? onChanged;
  final IMultiSelectDropdownDecoration? decoration;
  // final bool Function(List<T>)? initSelectionCriteria;
  final List<T>? initialItems;
  final String? Function(List<T>)? validator;
  final bool isEmptyValidation;
  final String? emptyMessage;

  const BtMultiSelect(
      {super.key,
      required this.hintText,
      required this.items,
      this.onChanged,
      this.initialItems,
      this.decoration,
      this.validator,
      this.isEmptyValidation = true,
      this.emptyMessage});

  @override
  Widget build(BuildContext context) {
    return IMultiSelectDropdown<T>.multiSelectSearch(
      initialItems: initialItems,
      hintText: hintText,
      items: items,
      decoration: decoration ??
          IMultiSelectDropdownDecoration(
            closedFillColor: Colors.grey.shade50,
          ),
      onListChanged: onChanged,
      listValidator: (value) {
        if (isEmptyValidation && value.isEmpty) {
          return emptyMessage ?? "select at least one $hintText";
        }

        if (validator != null) {
          return validator!(value);
        }
        return null;
      },
    );
  }
}
