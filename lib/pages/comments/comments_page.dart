import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/comments/comments_controller.dart';
import 'package:hiringbell/pages/common/realtime_communication/chat_stream_index.dart';
import 'package:hiringbell/pages/common/realtime_communication/chat_stream_service.dart';
import 'package:hiringbell/pages/comments/widgets/comments_heading.dart';
import 'package:hiringbell/pages/comments/widgets/post_info.dart';
import 'package:hiringbell/pages/common/error_page/error_page.dart';
import 'package:hiringbell/pages/view_apply_post/view_apply_post_controller.dart';

import '../home/home_controller.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  var viewController = Get.put(ViewPostController());
  var controller = Get.put(CommentsController());
  var home = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() async {
    var chatService = Get.find<ChatStreamService>();
    viewController.isLoading.value = true;
    await viewController.loadPostDetail();
    if (!viewController.isLoading.value && viewController.postsDetail != null) {
      debugPrint("Data loaded....");
      controller.commentChatId =
          "${viewController.postsDetail!.postedBy}_post_${viewController.postsDetail!.userPostId}";
      chatService.subscribePostComments(
        controller.commentChatId,
        controller.user!.userId.toString(),
      );

      chatService.loadComments(controller.commentChatId);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    var chatService = Get.find<ChatStreamService>();
    chatService.cleanChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        title: const Text("Comments"),
      ),
      body: Obx(
        () => viewController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : viewController.postsDetail == null
                ? const ErrorPage()
                : ChatStreamIndex(
                    groupId: controller.commentChatId,
                    senderId: controller.user!.userId.toString(),
                    recipientId: viewController.postsDetail!.postedBy.toString(),
                    isGroupChat: true,
                    chatHeaderWidget: const Column(
                      children: [
                        PostInfo(),
                        CommentsHeading(),
                      ],
                    ),
                  ),
      ),
    );
  }
}
