import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/common/index_card/index_page_card.dart';
import 'package:hiringbell/pages/posts/posts_controller.dart';
import 'package:hiringbell/pages/posts/widgets/post_header_card.dart';
import 'package:hiringbell/pages/posts/widgets/recent_post_title.dart';
import 'package:hiringbell/utilities/Util.dart';

class UserOwnPosts extends GetView<PostsController> {
  UserOwnPosts({super.key});

  Util util = Util.getInstance();

  @override
  Widget build(BuildContext context) {
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

            return Column(
              children: [
                if (index == 0) ...[
                  PostHeaderCard(),
                  const RecentPostTitle(),
                ],
                IndexPageCard(
                  jobPost: controller.posts.value[index],
                  isOwnPosts: true,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
