import 'package:flutter/material.dart';
import 'package:hiringbell/pages/common/bt_date_picker/bt_date_picker.dart';

class BtDatePickerWithLabel extends StatelessWidget {
  final String label;
  final String? hintText;
  final DateTime? initialValue;
  final String? Function(DateTime?)? validator;
  final ValueChanged<DateTime?>? onChanged;
  // final IconData? prefixIcon;
  final bool isEmptyValidation;
  final String? emptyMessage;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const BtDatePickerWithLabel({
    super.key,
    this.hintText,
    this.initialValue,
    this.validator,
    this.onChanged,
    // this.prefixIcon,
    this.isEmptyValidation = true,
    required this.label,
    this.emptyMessage,
    this.firstDate,
    this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        BtDatePicker(
          hintText: hintText ?? "Enter $label",
          initialValue: initialValue,
          firstDate: firstDate,
          lastDate: lastDate,
          onChanged: onChanged,
          validator: validator,
          isEmptyValidation: isEmptyValidation,
          emptyMessage: emptyMessage ?? "Please enter $label",
        ),
        const SizedBox(height: 2)
      ],
    );
  }
}
