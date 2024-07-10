import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hiringbell/pages/create_job/widget/form_card.dart';
import 'package:hiringbell/pages/registration/client_registration_controller.dart';
import 'package:hiringbell/utilities/util.dart';

class UserProfileImageUpload extends GetView<ClientRegistrationController> {
  const UserProfileImageUpload({super.key});

  @override
  Widget build(BuildContext context) {
    final Util util = Util.getInstance();
    return FormCard(
      title: "Profile Image",
      children: [
        GestureDetector(
          onTap: controller.pickImage,
          child: Obx(
            () => CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[200],
              // onBackgroundImageError: (o, s) => util.errorImageWidget(),
              // backgroundImage: CachedNetworkImageProvider(controller.user.imageURL??""),

              backgroundImage: bgImage(util),
              // backgroundImage: controller.pickedImage.value != null
              //     ? FileImage(File(controller.pickedImage.value!.path))
              //     : controller.user.imageURL != null
              //         ? util.getCachedImageFromUrl("sfsd") as ImageProvider
              //         : null,
              // backgroundImage: null,

              child: controller.pickedImage.value == null &&
                      controller.user.imageURL == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 30,
                          color: Colors.grey[800],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Tap to add\nphoto',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  ImageProvider<Object>? bgImage(Util util) {
    var imageURL = controller.user.imageURL;
    if (controller.pickedImage.value != null) {
      return FileImage(File(controller.pickedImage.value!.path));
    } else if (imageURL != null && imageURL.isNotEmpty) {
      return CachedNetworkImageProvider(util.getImagePath(imageURL) ?? "");
    } else {
      return null;
    }
  }
}
