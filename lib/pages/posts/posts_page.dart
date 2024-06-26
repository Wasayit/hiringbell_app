import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/posts/posts_controller.dart';
import 'package:hiringbell/pages/posts/widgets/user_own_posts.dart';

import '../../utilities/Util.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  var home = Get.put(PostsController());
  Util util = Util.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    debugPrint("Posts page loaded...");
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      home.onRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PostsController());

    return Obx(
      () => RefreshIndicator(
        onRefresh: controller.onRefresh,
        child: Container(
          color: Colors.black12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              controller.isHomepageReady.value
                  ? controller.posts.value.isNotEmpty
                      ? UserOwnPosts()
                      : const Center(
                          child: Text("No record found"),
                        )
                  : const Center(
                      child: CircularProgressIndicator(),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
