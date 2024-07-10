import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/view_apply_post/view_apply_post_controller.dart';
import 'package:jiffy/jiffy.dart';

class SavedStatus extends GetView<ViewPostController> {
  const SavedStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.postsDetail!.jobSavedOn != null
        ? Container(
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(6)),
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            margin: const EdgeInsets.only(
              top: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.bookmark_added,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 6,
                ),
                const Text(
                  "Saved on: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  Jiffy.parse(controller.postsDetail!.jobSavedOn.toString())
                      .format(pattern: "dd MMM, yyyy"),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          )
        : Container();
  }
}
