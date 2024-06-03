import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/common/index_card/image_viewer.dart';
import 'package:hiringbell/pages/home/home_controller.dart';
import 'package:hiringbell/pages/home/widgets/image_carousel.dart';
import 'package:hiringbell/pages/view_post/view_post_controller.dart';
import 'package:hiringbell/utilities/Util.dart';
import 'package:photo_view/photo_view.dart';

class PostImage extends GetView<ViewPostController> {
  PostImage({super.key});

  Util util = Util.getInstance();
  var home = Get.put(HomeController());

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
    // TODO: implement build
    return controller.postsDetail!.files != null &&
            controller.postsDetail!.files!.length == 1
        ? Center(
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: InkWell(
                onTap: () {
                  _showImageOverlay(
                      home.getImageUrl(controller.postsDetail!.files!));
                },
                child: util.getCachedImage(
                    home.getImageUrl(controller.postsDetail!.files!)),
              ),
            ),
          )
        : InkWell(
            onTap: () {
              _showImageOverlay(
                  home.getImageUrl(controller.postsDetail!.files!));
            },
            child: Center(
              child: ImageCarousel(
                images: controller.postsDetail!.files!,
              ),
            ),
          );
  }
}
