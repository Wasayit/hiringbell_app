import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/common/bot_container/bt_container.dart';
import 'package:hiringbell/pages/view_apply_post/view_apply_post_controller.dart';
import 'package:hiringbell/pages/view_apply_post/widgets/about_job.dart';
import 'package:hiringbell/pages/view_apply_post/widgets/applied_status.dart';
import 'package:hiringbell/pages/view_apply_post/widgets/feature_detail.dart';
import 'package:hiringbell/pages/view_apply_post/widgets/post_image.dart';
import 'package:hiringbell/pages/view_apply_post/widgets/publisher_detail.dart';
import 'package:hiringbell/pages/view_apply_post/widgets/saved_status.dart';
import 'package:jiffy/jiffy.dart';

class PostDetail extends GetView<ViewPostController> {
  const PostDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 12,
          ),
          BtContainer(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PublisherDetail(),
                const SizedBox(
                  height: 4,
                ),
                Text(controller.getTitleSubDesc()),
                const SizedBox(
                  height: 10,
                ),
                FeatureDetail(
                  icon: CupertinoIcons.briefcase,
                  titleWidget: Text(
                    "${controller.postsDetail!.minimumCTC} - ${controller.postsDetail!.maximumCTC} - "
                    "${controller.postsDetail!.currencyName} Per Month.",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                FeatureDetail(
                  icon: Icons.payments_outlined,
                  titleWidget: Wrap(children: [
                    const Text(
                      "Currency: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${controller.postsDetail!.currencyName}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ]),
                ),
                FeatureDetail(
                  icon: CupertinoIcons.list_bullet,
                  titleWidget: Wrap(
                    children: [
                      const Text(
                        "Roles: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${controller.postsDetail!.jobTypeName}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "(# open posts: ${controller.postsDetail!.noOfPosts})",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => !controller.isApplying.value
                      ? const AppliedStatus()
                      : const SizedBox.shrink(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => controller.jobSavedStatusTrigger.value &&
                          !controller.jobStatusTrigger.value
                      ? const SavedStatus()
                      : const SizedBox.shrink(),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: PostImage(),
          ),
          const AboutJob(),
        ],
      ),
    );
  }
}
