import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/home/widgets/search_box.dart';
import 'package:hiringbell/pages/page_layout/page_layout_controller.dart';
import 'package:hiringbell/pages/page_layout/widget/screen_manager.dart';
import 'package:hiringbell/pages/view_applied_jobs/view_applied_jobs_page.dart';
import 'package:hiringbell/pages/view_apply_post/view_apply_post_detail.dart';
import 'package:hiringbell/pages/view_saved_jobs/view_saved_jobs_page.dart';
import 'package:hiringbell/utilities/Util.dart';

import '../../models/navigate.dart';

class PageLayoutIndex extends StatefulWidget {
  const PageLayoutIndex({super.key});

  @override
  State<PageLayoutIndex> createState() => _PageLayoutIndexState();
}

class _PageLayoutIndexState extends State<PageLayoutIndex> {
  var controller = Get.put(PageLayoutController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // handle message
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        controller.onItemTapped(0);
        var result = Get.to(const ViewApplyPostDetail());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 2,
              child: IconButton(
                onPressed: (){
                  Get.toNamed(Navigate.profile);
                },
                icon: CircleAvatar(
                  radius: 23.0,
                  backgroundColor: Colors.grey.shade300,
                  child: Text(controller.user.firstName[0]),
                ),
                /*child: PopupMenuButton(
                  icon: CircleAvatar(
                    radius: 23.0,
                    backgroundColor: Colors.grey.shade300,
                    child: Text(controller.user.firstName[0]),
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                        value: 'Applied_Jobs',
                        child: Row(
                          children: [
                            Icon(Icons.check),
                            SizedBox(width: 5),
                            Text('Applied Jobs')
                          ],
                        )),
                    const PopupMenuItem(
                        value: 'Saved_Jobs',
                        child: Row(
                          children: [
                            Icon(Icons.bookmark),
                            SizedBox(width: 5),
                            Text('Saved Jobs')
                          ],
                        )),
                  ],
                  onSelected: (value) {
                    if (value == 'Applied_Jobs') {
                      Get.to(const ViewAppliedJobsPage());
                      return;
                    }
                    if (value == 'Saved_Jobs') {
                      Get.to(const ViewSavedJobsPage());
                      return;
                    }
                  },
                ),*/
              ),
            ),
            const Expanded(
              flex: 9,
              child: Text("Hiring Bell..."), // SearchBox(),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {
                  Util.cleanAll();
                  Get.offAllNamed(Navigate.login);
                },
                icon: const Icon(Icons.power_settings_new_outlined),
              ),
            )
          ],
        ),
      ),
      body: Obx(
        () => ScreenManager(index: controller.selectedIndex.value),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            /* BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined),
              label: 'Friends',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.portrait_sharp),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active),
              label: 'Notification',
            ),*/
            BottomNavigationBarItem(
              icon: Icon(Icons.workspace_premium_outlined),
              label: 'My Posts',
            ),
          ],
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.grey,
          onTap: (index) => {controller.onItemTapped(index)},
        ),
      ),
    );
  }
}
