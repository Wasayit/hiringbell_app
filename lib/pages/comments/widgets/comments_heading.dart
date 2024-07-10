import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/comments/comments_controller.dart';

class CommentsHeading extends GetView<CommentsController> {
  const CommentsHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Comments",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    "Most relevant",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.sort)
                ],
              ),
            ],
          ),
        ),
        /*ElevatedButton(
          onPressed: controller.playRecording,
          child: const Text("Play"),
        ),*/
        Text(
          "To record your message long press mic icon",
          style: TextStyle(
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
