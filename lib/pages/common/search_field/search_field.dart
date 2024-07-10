import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/models/dropdown_items.dart';
import 'package:hiringbell/pages/common/search_field/filter_records_section.dart';
import 'package:hiringbell/services/http_service.dart';
import 'package:hiringbell/utilities/Util.dart';

class SearchField extends StatelessWidget {
  final Function(DropdownItems)? onSelected;
  final String? searchUrl;
  final Icon? searchIcon;
  final bool? isIcon;
  final List<DropdownItems>? items;
  final double ratio;
  final Widget? child;
  final String? buttonText;

  const SearchField({super.key, required this.ratio})
      : assert(true),
        isIcon = false,
        buttonText = null,
        items = null,
        onSelected = null,
        searchUrl = null,
        child = null,
        searchIcon = null;

  const SearchField.button({
    super.key,
    required this.onSelected,
    required this.ratio,
    required this.buttonText,
    this.items,
  })  : assert(true),
        isIcon = false,
        searchUrl = null,
        child = null,
        searchIcon = null;

  const SearchField.buttonSearch({
    super.key,
    required this.onSelected,
    required this.ratio,
    this.searchUrl,
    required this.buttonText,
    this.child,
  })  : assert(true),
        isIcon = false,
        items = null,
        searchIcon = null;

  const SearchField.iconCustom({
    super.key,
    required this.searchIcon,
    required this.ratio,
    this.child,
  })  : assert(true),
        searchUrl = null,
        onSelected = null,
        items = null,
        buttonText = null,
        isIcon = true;

  const SearchField.icon({
    super.key,
    required this.searchIcon,
    required this.onSelected,
    required this.ratio,
    this.items,
  })  : assert(true),
        searchUrl = null,
        child = null,
        buttonText = null,
        isIcon = true;

  const SearchField.iconSearch({
    super.key,
    required this.searchIcon,
    required this.onSelected,
    required this.ratio,
    this.child,
    this.searchUrl,
  })  : assert(true),
        items = null,
        buttonText = null,
        isIcon = true;

  @override
  Widget build(BuildContext context) {
    return (isIcon != null && isIcon!)
        ? IconButton(
            onPressed: () => _showFullScreenBottomSheet(context),
            icon: searchIcon!,
          )
        : ElevatedButton(
            onPressed: () => _showFullScreenBottomSheet(context),
            child: Text(buttonText!),
          );
  }

  Widget? userWidget() {
    if (child == null) {
      return FilterRecordsSection(
        searchUrl: searchUrl,
        onSelected: onSelected,
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(
          top: Constants.contentVSpace * 3,
          left: Constants.contentHSpace * 2,
          right: Constants.contentHSpace * 2,
          bottom: Constants.contentVSpace,
        ),
        child: child,
      );
    }
  }

  void _showFullScreenBottomSheet(BuildContext context) {
    FocusScope.of(context).unfocus();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: ratio,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              width: double.infinity,
              child: userWidget(),
            ),
          ),
        );
      },
    );
  }
}
