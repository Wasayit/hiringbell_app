import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/firebase_options.dart';
import 'package:hiringbell/models/navigate.dart';
import 'package:hiringbell/pages/common/realtime_communication/chat_stream_service.dart';
import 'package:hiringbell/pages/create_job/job_post_page.dart';
import 'package:hiringbell/pages/findFriends/findFriends_page.dart';
import 'package:hiringbell/pages/home/home_page.dart';
import 'package:hiringbell/pages/login/login_page.dart';
import 'package:hiringbell/pages/page_layout/page_layout_index.dart';
import 'package:hiringbell/pages/posts/posts_page.dart';
import 'package:hiringbell/pages/profile/profile_page.dart';
import 'package:hiringbell/pages/settings/settings_page.dart';
import 'package:hiringbell/push_notification.dart';
import 'package:hiringbell/services/http_service.dart';
import 'package:hiringbell/utilities/Util.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Obtain shared preferences.
  preConfigure();
  runApp(const MainApp());
}

Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    debugPrint("Notification received");
    debugPrint("Handling a background message: ${message.messageId}");
    debugPrint('Message data: ${message.data}');
    debugPrint('Message notification: ${message.notification?.title}');
    debugPrint('Message notification: ${message.notification?.body}');
  }
}

Future<void> checkAutoLogin() async {
  var pref = await SharedPreferences.getInstance();
  Util.init(pref);
}

Future<void> preConfigure() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // init push notification
  PushNotifications.init();

  // init local notification
  PushNotifications.localNotificationInit();

  // Listen to background notification
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

/*  // handle message
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if(message.notification != null) {
      Get.toNamed(Navigate.homeLayout,
          arguments: message.data
      );
    }
  });*/

  // check auto login
  await checkAutoLogin();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  final ColorScheme colorScheme = const ColorScheme(
    // primary: Color.fromRGBO(21, 26, 74, 1),
    primary: Color.fromRGBO(21, 26, 74, 1),
    // <---- I set white color here
    secondary: Color(0x44444444),
    // page background default to all pages
    surface: Color(0xFFFFFFFF),
    error: Colors.redAccent,
    onError: Colors.redAccent,
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFFFFFFFF),
    //  default text color
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        HttpService.getInstance();
        Get.put(ChatStreamService());
      }),
      debugShowCheckedModeBanner: false,
      initialRoute: Navigate.login,
      getPages: [
        GetPage(name: Navigate.profile, page: () => const ProfilePage()),
        GetPage(name: Navigate.home, page: () => const HomePage()),
        GetPage(name: Navigate.settings, page: () => const SettingPage()),
        GetPage(name: Navigate.post, page: () => const PostsPage()),
        GetPage(name: Navigate.jobPost, page: () => const JobPostPage()),
        GetPage(name: Navigate.homeLayout, page: () => const PageLayoutIndex()),
        GetPage(
            name: Navigate.findFriends, page: () => const FindFriendsPage()),
        GetPage(name: Navigate.login, page: () => const LoginPage()),
      ],
      unknownRoute:
          GetPage(name: Navigate.login, page: () => const LoginPage()),
      theme: ThemeData(
        colorScheme: colorScheme,
      ),
    );
  }
}
