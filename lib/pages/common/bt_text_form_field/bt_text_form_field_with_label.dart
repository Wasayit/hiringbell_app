import 'package:flutter/material.dart';

import 'bt_text_form_field.dart';

class BTTextFormFieldWithLabel extends StatelessWidget {
  final String label;
  final String? hintText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final int? minLines;
  final int? maxLines;
  final IconData? prefixIcon;
  final bool isEmptyValidation;
  final String? emptyMessage;
  final bool obscureText;
  final TextEditingController? controller;

  const BTTextFormFieldWithLabel({
    super.key,
    this.hintText,
    this.initialValue,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.maxLines,
    this.minLines,
    this.prefixIcon,
    this.isEmptyValidation = true,
    required this.label,
    this.emptyMessage,
    this.obscureText = false,
    this.controller,
  });

  factory BTTextFormFieldWithLabel.currency({
    String? initialValue,
    final String? Function(String?)? validator,
    final ValueChanged<String>? onChanged,
    final bool? isEmptyValidation,
    required final String label,
    final String? emptyMessage,
    final TextEditingController? controller,
  }) {
    return BTTextFormFieldWithLabel(
      label: label,
      hintText: "0.0",
      emptyMessage: emptyMessage,
      initialValue: initialValue,
      isEmptyValidation: isEmptyValidation ?? true,
      keyboardType: TextInputType.number,
      prefixIcon: Icons.currency_rupee,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(
          height: 5,
        ),
        BTTextFormField(
          controller: controller,
          hintText: hintText ?? "Enter $label",
          initialValue: initialValue,
          onChanged: onChanged,
          validator: validator,
          isEmptyValidation: isEmptyValidation,
          emptyMessage: emptyMessage ?? "Please enter $label",
          keyboardType: keyboardType,
          maxLines: maxLines,
          minLines: minLines,
          prefixIcon: prefixIcon,
          obscureText: obscureText,
        ),
        const SizedBox(height: 2)
      ],
    );
  }
}
