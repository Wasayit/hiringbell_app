// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/view_saved_jobs/widgets/saved_jobs_card.dart';
import 'package:hiringbell/pages/view_saved_jobs/view_saved_jobs_controller.dart';
import 'package:hiringbell/utilities/Util.dart';

class ViewSavedJobsPage extends StatefulWidget {
  const ViewSavedJobsPage({super.key});

  @override
  State<ViewSavedJobsPage> createState() => _ViewSavedJobsPage();
}

class _ViewSavedJobsPage extends State<ViewSavedJobsPage> {
  var controller = Get.put(ViewSavedJobsController());
  Util util = Util.getInstance();

  @override
  void initState() {
    super.initState();

    controller.onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ViewSavedJobsController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        title: const Text("Saved Jobs"),
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: controller.onRefresh,
          child: Container(
            color: Colors.black12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                controller.isPageReady.value
                    ? controller.posts.value.isNotEmpty
                        ? const SavedJobsCard()
                        : const Center(
                            child: Text("No saved jobs found"),
                          )
                    : const Center(
                        child: CircularProgressIndicator(),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
