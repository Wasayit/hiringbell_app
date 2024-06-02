import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/create_job/job_post_controller.dart';
import 'package:hiringbell/pages/create_job/widget/job_form.dart';

class JobPostPage extends StatefulWidget {
  const JobPostPage({super.key});

  @override
  State<JobPostPage> createState() => _JobPostPageState();
}

class _JobPostPageState extends State<JobPostPage> {
  var controller = Get.put(JobPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        title: const Text("Post a job"),
      ),
      body: JobForm(),
    );
  }
}
