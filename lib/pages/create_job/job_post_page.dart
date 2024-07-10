import 'package:flutter/material.dart';
import 'package:hiringbell/models/posts.dart';
import 'package:hiringbell/pages/create_job/widget/job_form.dart';

class JobPostPage extends StatelessWidget {
  final Posts? existingPost;
  const JobPostPage({super.key, this.existingPost});

  @override
  Widget build(BuildContext context) {
    var action = existingPost == null ? "Post" : "Edit";
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        title: Text("$action a job"),
      ),
      body: JobForm(existingPost: existingPost),
    );
  }
}
