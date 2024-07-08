import 'package:flutter/material.dart';

InputDecoration btInputDecoration({
  IconData? prefixIcon,
  String? hintText,
}) {
  return InputDecoration(
    border: const OutlineInputBorder(),
    filled: true,
    fillColor: Colors.white,
    contentPadding: prefixIcon == null
        ? const EdgeInsets.all(10.0)
        : const EdgeInsets.symmetric(vertical: 2),
    prefixIcon: prefixIcon == null
        ? null
        : Icon(
            prefixIcon,
            color: Colors.blueAccent,
            size: 20,
          ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.0),
    ),
    hintText: hintText,
  );
}
