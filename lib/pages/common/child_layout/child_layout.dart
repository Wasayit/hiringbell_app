import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiringbell/models/navigate.dart';
import 'package:hiringbell/utilities/Util.dart';

class ChildLayout extends StatelessWidget {
  Widget child;
  String title;
  bool enableSettingOption;

  ChildLayout(
      {super.key,
      required this.child,
      required this.title,
      this.enableSettingOption = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: enableSettingOption ? 9 : 10,
              child: Text(title), // SearchBox(),
            ),
            if (enableSettingOption)
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    Util.cleanAll();
                    Get.offAllNamed(Navigate.login);
                  },
                  icon: const Icon(Icons.settings),
                ),
              )
          ],
        ),
      ),
      body: child,
    );
  }
}
