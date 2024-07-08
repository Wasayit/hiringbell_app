import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/common/bt_divider/bt_divider.dart';
import 'package:hiringbell/pages/profile/profile_controller.dart';

import '../../../models/constants.dart';

class AnalyticsReports extends GetView<ProfileController> {
  const AnalyticsReports({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.pagePadding,
            vertical: Constants.pagePadding,
          ),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Analytics",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Constants.fontSize * 1.5,
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text("Private to you"),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const ListTile(
                leading: Icon(Icons.people_alt),
                title: Wrap(
                  children: [
                    Text("0 profile views"),
                    Text("Discover who's viewed your profile"),
                  ],
                ),
              ),
              BtDivider(
                space: 15,
              ),
              const SizedBox(
                height: 5,
              ),
              const ListTile(
                leading: Icon(Icons.area_chart),
                title: Wrap(
                  children: [
                    Text("0 post impressions"),
                    Text("Start a post to increase engagement"),
                  ],
                ),
              ),
              BtDivider(
                space: 15,
              ),
              const SizedBox(
                height: 5,
              ),
              const ListTile(
                leading: Icon(Icons.search),
                title: Wrap(
                  children: [
                    Text("0 search appearance"),
                    Text("See how often you appear in search results"),
                  ],
                ),
              ),
              BtDivider(
                space: 15,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        BtDivider(
          thickness: 14,
        ),
      ],
    );
  }
}
