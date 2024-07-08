import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/post_new_job/post_new_job_controller.dart';

class SubmitSection extends GetView<PostNewJobController> {
  const SubmitSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  const Text(
                    "Click below button to publish your post",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Make sure after click this button you post will get reflected.",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(
              () => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                child: SizedBox(
                  width: 150,
                  child: controller.isSubmitted.value
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Wait ..."),
                          ],
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.publish_outlined),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Publish"),
                          ],
                        ),
                ),
                onPressed: () => {
                  controller.saveFormData(),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
