// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/view_applied_jobs/view_applied_jobs_controller.dart';
import 'package:hiringbell/pages/view_applied_jobs/widgets/applied_jobs_card.dart';
import 'package:hiringbell/utilities/Util.dart';

class ViewAppliedJobsPage extends StatefulWidget {
  const ViewAppliedJobsPage({super.key});

  @override
  State<ViewAppliedJobsPage> createState() => _ViewAppliedJobsPage();
}

class _ViewAppliedJobsPage extends State<ViewAppliedJobsPage> {
  var controller = Get.put(ViewAppliedJobsController());
  Util util = Util.getInstance();

  @override
  void initState() {
    super.initState();

    controller.onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ViewAppliedJobsController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        title: const Text("Applied Jobs"),
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
                        ? const AppliedJobsCard()
                        : const Center(
                            child: Text("No applied jobs found"),
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
