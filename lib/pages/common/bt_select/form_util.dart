import 'package:flutter/material.dart';

class FormUtil {
  static bool isEdit = false;

  static TextInputType getKeyboardType<T>(T value, int? minLines) {
    if (minLines != null && minLines > 1) return TextInputType.multiline;

    final keyboardTypeMap = {
      String: TextInputType.text,
      int: TextInputType.number,
      double: TextInputType.number,
      // DateTime:TextInputType.datetime,
      // Add other mapping data types
    };
    return keyboardTypeMap[value.runtimeType] ?? TextInputType.text;
  }
}
