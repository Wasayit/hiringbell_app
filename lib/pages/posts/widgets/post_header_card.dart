import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/posts/posts_controller.dart';
import 'package:hiringbell/pages/registration/client_registration_page.dart';
import 'package:hiringbell/utilities/util.dart';
import 'package:jiffy/jiffy.dart';

class PostHeaderCard extends StatelessWidget {
  PostHeaderCard({super.key});

  var controller = Get.put(PostsController());

  @override
  Widget build(BuildContext context) {
    var currentUser = controller.util?.getUserDetail();
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 40.0,
            backgroundImage: NetworkImage(
              "https://cdn-icons-png.flaticon.com/512/149/149071.png",
            ),
          ),
          // Profile information widgets go here
          const SizedBox(height: 10.0),
          Text(
            "${currentUser?.firstName} ${currentUser?.lastName}",
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
              "Since ${Jiffy.parse(currentUser?.createdOn.toString() ?? "").format(pattern: "dd MMM, yyyy")}"),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on),
                    Text(currentUser?.address ?? "N/A"),
                  ],
                ),
              ),
              SizedBox(
                width: 120,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                    ),
                    backgroundColor: WidgetStateProperty.all<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    controller.loadJobPostPage();
                  },
                  label: const Text(
                    "Create a job",
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(
                    Icons.post_add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          // const SizedBox(height: 10),
          // GridView.count(
          //     shrinkWrap: true,
          //     crossAxisCount: 2,
          //     mainAxisSpacing: 15,
          //     crossAxisSpacing: 15,
          //     childAspectRatio: 3 / 0.8,
          //     children: const [
          //       UserRegButton(
          //         roleName: "Client",
          //         isJobSeeker: true,
          //       ),
          //       UserRegButton(
          //         roleName: "Client",
          //         isJobSeeker: true,
          //         userId: 29,
          //       ),
          //       UserRegButton(
          //         roleName: "Agent",
          //       ),
          //       UserRegButton(
          //         roleName: "Agent",
          //         userId: 28,
          //       ),
          //     ]),
        ],
      ),
    );
  }
}

class UserRegButton extends StatelessWidget {
  final int userId;
  final bool isJobSeeker;
  final String roleName;
  const UserRegButton({
    super.key,
    this.userId = 0,
    this.isJobSeeker = false,
    required this.roleName,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
              userId > 0 ? Colors.amberAccent : Colors.blue),
          foregroundColor:
              WidgetStatePropertyAll(userId > 0 ? Colors.black : Colors.white),
        ),
        onPressed: () {
          Get.to(ClientRegistrationForm(
            userId: userId,
            isJobSeeker: isJobSeeker,
            label: "$roleName Registration ${userId > 0 ? "Edit" : ""}",
          ));
        },
        child: Text("$roleName Reg. ${userId > 0 ? "Edit" : ""}"));
  }
}
