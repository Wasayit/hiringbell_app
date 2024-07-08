import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hiringbell/models/constants.dart';

import '../post_new_job_controller.dart';

class UploadFiles extends GetView<PostNewJobController> {
  const UploadFiles({super.key});

  Widget loadImage() {
    if (!controller.isFileReady.value) {
      return Padding(
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
      );
    } else {
      return Obx(
        () => Wrap(
          children: [
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
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Image.file(
                          File(controller.pickedImages.value[index].path),
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
                          controller.removeImage(
                              controller.pickedImages.value[index].name);
                          Fluttertoast.showToast(msg: "Image removed");
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
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: controller.util.getCachedImageFromUrl(
                            controller.serverImages.value[index].filePath),
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
                              controller.serverImages.value[index]);
                          Fluttertoast.showToast(msg: "Image removed");
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.pagePadding,
      ),
      child: Column(
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
                fontSize: Constants.fontSize * 1.4,
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
              child: Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      loadImage(),
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
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
