import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/posts.dart';
import 'package:hiringbell/pages/common/child_layout/child_layout.dart';
import 'package:hiringbell/pages/post_new_job/post_new_job_controller.dart';
import 'package:hiringbell/pages/post_new_job/widget/basic_detail.dart';
import 'package:hiringbell/pages/post_new_job/widget/submit_section.dart';
import 'package:hiringbell/pages/post_new_job/widget/upload_files.dart';

class PostNewJobIndex extends StatefulWidget {
  final Posts? post;

  const PostNewJobIndex({super.key, required this.post});

  @override
  State<PostNewJobIndex> createState() => _PostNewJobIndexState();
}

class _PostNewJobIndexState extends State<PostNewJobIndex> {
  final controller = Get.put(PostNewJobController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.resetState();

    if (widget.post == null) {
      controller.setPostId(0);
      controller.getInitForm();
    } else {
      controller.setPostId(widget.post!.userPostId!);
      controller.loadFormData();
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.setContext(context);
    return ChildLayout(
      title: "Post new job",
      child: Form(
        key: controller.formKey,
        child: ListView(
          children: const [
            UploadFiles(),
            BasicDetail(),
            SubmitSection(),
          ],
        ),
      ),
    );
  }
}
