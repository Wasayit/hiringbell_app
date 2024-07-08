import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/comments/comments_controller.dart';
import 'package:hiringbell/pages/comments/widgets/comments_heading.dart';
import 'package:hiringbell/pages/comments/widgets/post_info.dart';

class CommentsChat extends GetView<CommentsController> {
  const CommentsChat({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      controller: controller.scrollController,
      children: const [
        PostInfo(),
        CommentsHeading(),
      ],
    );
  }
}
