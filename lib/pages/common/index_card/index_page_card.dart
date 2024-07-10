import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/models/posts.dart';
import 'package:hiringbell/pages/comments/comments_page.dart';
import 'package:hiringbell/pages/common/index_card/image_viewer.dart';
import 'package:hiringbell/pages/create_job/job_post_page.dart';
import 'package:hiringbell/pages/home/home_controller.dart';
import 'package:hiringbell/pages/view_apply_post/view_apply_post_detail.dart';
import 'package:hiringbell/utilities/Util.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import '../../home/widgets/image_carousel.dart';
import 'package:like_button/like_button.dart';

class IndexPageCard extends StatefulWidget {
  final Posts jobPost;
  final bool isOwnPosts;
  const IndexPageCard(
      {super.key, required this.jobPost, this.isOwnPosts = false});

  @override
  State<IndexPageCard> createState() => _IndexPageCardState();
}

class _IndexPageCardState extends State<IndexPageCard> {
  final Util util = Util.getInstance();
  late Posts posts;
  final controller = Get.put(HomeController());
  int imageIndex = 0;
  @override
  initState() {
    super.initState();
    posts = widget.jobPost;
  }

  void applyForJob() async {
    await Get.to(const ViewApplyPostDetail(), arguments: posts.userPostId);

    if (controller.getAppliedExecutedState()) {
      posts.appliedOn = DateTime.now();
      setState(() {
        posts = posts;
      });
    }
  }

  void editPost(String value) async {
    if (value == 'edit') {
      var result = await Get.to(JobPostPage(existingPost: posts));

      if (result is Posts) {
        result.isLiked = posts.isLiked;
        result.profileImage = posts.profileImage;
        result.appliedOn = posts.appliedOn;
        setState(() {
          posts = result;
        });
        return;
      }
    }
  }

  _showImageOverlay(String imageUrl) {
    Navigator.of(Get.context!).push(
      ImageViewerContainer(
        child: SizedBox(
          height: MediaQuery.of(Get.context!).size.height * .30,
          width: MediaQuery.of(Get.context!).size.width,
          child: PhotoView(
            imageProvider: CachedNetworkImageProvider(
              imageUrl,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: posts.profileImage!.isEmpty
                ? CircleAvatar(
                    radius: 30.0,
                    backgroundColor: controller.getBackgroundColor(
                      posts.fullName![0].toUpperCase(),
                    ),
                    child: Text(posts.fullName![0]),
                  )
                : CircleAvatar(
                    radius: 30.0,
                    backgroundImage: util.getImageProvider(Constants.empty),
                    backgroundColor: Colors.transparent,
                  ),
            // trailing: const Icon(Icons.keyboard_control_outlined),
            trailing: posts.appliedOn != null
                ? const Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                        size: 20,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Applied",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      )
                    ],
                  )
                : !widget.isOwnPosts
                    ? const SizedBox()
                    : PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit),
                                SizedBox(width: 5),
                                Text('Edit')
                              ],
                            ),
                          ),
                          /*const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete),
                            SizedBox(width: 5),
                            Text('Delete')
                          ],
                        ),
                      ),*/
                        ],
                        onSelected: editPost,
                      ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  posts.fullName!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                const Text(
                  "0 followers",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                const Row(
                  children: [
                    Text(
                      "2h",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Icon(
                      Icons.gps_fixed,
                      size: 14,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(posts.shortDescription!),
                Text(posts.completeDescription!),
              ],
            ),
          ),
          // LoadingPlaceholder(child: const Placeholder(),),
          if (posts.files.length == 1)
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: InkWell(
                  onTap: () {
                    _showImageOverlay(controller.getImageUrl(posts.files[0]));
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .30,
                    width: MediaQuery.of(context).size.width,
                    child: util
                        .getCachedImage(controller.getImageUrl(posts.files[0])),
                  ),
                ),
              ),
            )
          else
            InkWell(
              onTap: () {
                _showImageOverlay(
                    controller.getImageUrl(posts.files[imageIndex]));
              },
              child: Center(
                child: ImageCarousel(
                  images: posts.files,
                  onChanged: (index) => imageIndex = index,
                ),
              ),
            ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: const Divider(
              color: Colors.black12,
              height: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /*const IconButton(
                  onPressed: null,
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.thumb_up_alt_outlined,
                        color: Colors.black54,
                        size: 18,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "Like",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.black54),
                      ),
                    ],
                  ),
                ),*/
                if (util.getUserDetail().userId != posts.postedBy)
                  LikeButton(
                    onTap: (isLiked) async {
                      bool success = await (isLiked
                          ? controller.removeLikedPost(posts)
                          : controller.addLikePost(posts));
                      if (!success) return !isLiked;
                      posts.isLiked = isLiked;
                      return isLiked;
                    },
                    isLiked: posts.isLiked,
                    likeCount: 0,
                    countPostion: CountPostion.bottom,
                    countBuilder: (likeCount, isLiked, text) {
                      return Transform.translate(
                        offset: const Offset(0, -5),
                        child: Text(isLiked ? "Liked" : "Like",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black54)),
                      );
                    },
                    likeBuilder: (isTapped) {
                      return Icon(
                        Icons.thumb_up,
                        size: 18,
                        color: isTapped ? Colors.blue : Colors.grey,
                      );
                    },
                  ),
                IconButton(
                  onPressed: () async {
                    await Share.share("https://www.hiringbell.com");
                  },
                  icon: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.black54,
                        size: 18,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "Share",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.to(const CommentsPage(), arguments: posts.userPostId);
                  },
                  icon: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.comment,
                        color: Colors.black54,
                        size: 18,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "Comment",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: applyForJob,
                  icon: posts.appliedOn != null ||
                          widget.isOwnPosts ||
                          util.getUserDetail().userId == posts.postedBy
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.remove_red_eye_outlined,
                              color: Colors.black54,
                              size: 18,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "View",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54),
                            ),
                          ],
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.call,
                              color: Colors.black54,
                              size: 18,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Apply",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
