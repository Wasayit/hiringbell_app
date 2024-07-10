import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/posts.dart';
import 'package:hiringbell/pages/create_job/job_post_controller.dart';
import 'package:hiringbell/pages/create_job/widget/action_card.dart';
import 'package:hiringbell/pages/create_job/widget/basic_detail.dart';
import 'package:hiringbell/pages/create_job/widget/other_detail.dart';
import 'package:hiringbell/pages/create_job/widget/salary_detail.dart';
import 'package:hiringbell/pages/create_job/widget/upload_files.dart';
import 'package:hiringbell/pages/create_job/widget/work_detail.dart';

class JobForm extends StatelessWidget {
  final Posts? existingPost;
  JobForm({super.key, this.existingPost});
  late JobPostController controller;

  Future<JobPostController> initializeController() async {
    controller = JobPostController(jobPostId_: existingPost?.userPostId);
    await controller.onInitRefresh();
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    // return jobFormWidget(controller: controller);
    return FutureBuilder<JobPostController>(
        future: initializeController(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Get.put(snapshot.data!);
            return JobFormWidget(controller: controller);
          }
        });
  }
}

class JobFormWidget extends StatelessWidget {
  const JobFormWidget({
    super.key,
    required this.controller,
  });

  final JobPostController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        color: Colors.grey.shade50,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        width: double.infinity,
        child: Form(
          key: controller.formKey,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BasicDetail(),
              SalaryDetail(),
              WorkDetail(),
              OtherDetail(),
              UploadFiles(),
              ActionCard(),
            ],
          ),
        ),
      ),
    );
  }
}
