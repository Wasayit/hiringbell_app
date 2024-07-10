import 'package:flutter/cupertino.dart';
import 'package:hiringbell/models/constants.dart';

class DropdownItems<T> {
  T value;
  String text = Constants.empty;
  Icon? icon;

  DropdownItems({
    required this.value,
    required this.text,
    this.icon,
  });

  @override
  String toString() {
    return text;
  }
}
