import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hiringbell/pages/create_job/job_post_controller.dart';
import 'package:hiringbell/utilities/util.dart';

class UploadFiles extends GetView<JobPostController> {
  const UploadFiles({super.key});

  @override
  Widget build(BuildContext context) {
    final Util util = Util.getInstance();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 4,
          ),
          child: Text(
            "Upload files",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Card(
          color: Colors.white,
          elevation: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  controller.isImagePicked.value
                      ? controller.isFileReady.value
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 20,
                              ),
                              child: Text(
                                "No image uploaded, click upload button to upload at least 1 image.",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Obx(
                              () => Wrap(children: [
                                ...List.generate(
                                  controller.pickedImages.value.length,
                                  (index) {
                                    return Stack(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(4.0),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 4,
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 10,
                                            ),
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Image.file(
                                              File(controller.pickedImages
                                                  .value[index].path),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: InkWell(
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                              child: const Icon(
                                                Icons.remove_circle,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                            ),
                                            onTap: () {
                                              controller.removeImage(controller
                                                  .pickedImages
                                                  .value[index]
                                                  .name);
                                              Fluttertoast.showToast(
                                                  msg: "Image removed");
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                ...List.generate(
                                  controller.serverImages.value.length,
                                  (index) {
                                    return Stack(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(4.0),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 4,
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 10,
                                            ),
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: util.getCachedImageFromUrl(
                                                controller.serverImages
                                                    .value[index].filePath),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: InkWell(
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                              child: const Icon(
                                                Icons.remove_circle,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                            ),
                                            onTap: () {
                                              controller.removeServerImage(
                                                  controller.serverImages
                                                      .value[index]);
                                              Fluttertoast.showToast(
                                                  msg: "Image removed");
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ]),
                            )
                      : const CircularProgressIndicator(),
                  ElevatedButton(
                    onPressed: controller.pickImages,
                    child: const Text(
                      "Pick Image from Gallery",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("All field are mandatory in this section"),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
