// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/common/index_card/index_page_card.dart';
import 'package:hiringbell/pages/view_applied_jobs/view_applied_jobs_controller.dart';

class AppliedJobsCard extends StatelessWidget {
  const AppliedJobsCard({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ViewAppliedJobsController());
    return Obx(
      () => Expanded(
        child: ListView.builder(
          controller: controller.scrollController,
          itemCount: controller.hasMore.value
              ? controller.posts.value.length + 1
              : controller.posts.value.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            if (index >= controller.posts.value.length) {
              if (!controller.isLoading.value) {
                controller.loadNextPage();
              }

              return const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 32,
                ),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return IndexPageCard(jobPost: controller.posts.value[index]);
          },
        ),
      ),
    );
  }
}
