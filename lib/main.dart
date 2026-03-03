import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_1/firebase/push_notification/firebase_push_api.dart';
import 'package:flutter_basics_1/firebase_options.dart';
import 'package:flutter_basics_1/pages/advanced_layout/custom_scroll/custom_scroll_show_case.dart';
import 'package:flutter_basics_1/pages/advanced_layout/list_grid_showcase.dart';
import 'package:flutter_basics_1/pages/advanced_layout/sliver_mastery.dart';
import 'package:flutter_basics_1/pages/animations/explecit_animation.dart';
import 'package:flutter_basics_1/pages/animations/implecit_animation.dart';
import 'package:flutter_basics_1/pages/animations/implicit_animations_page.dart';
import 'package:flutter_basics_1/pages/basic_widget2.dart';
import 'package:flutter_basics_1/pages/basic_widget_1.dart';
import 'package:flutter_basics_1/pages/basic_widget_3.dart';
import 'package:flutter_basics_1/pages/basic_widget_4.dart';
import 'package:flutter_basics_1/pages/form_and_validation/complete/personal_info_screen.dart';
import 'package:flutter_basics_1/pages/form_and_validation/my_form.dart';
import 'package:flutter_basics_1/home/home.dart';
import 'package:flutter_basics_1/pages/layout_styling/all_buttons_page.dart';
import 'package:flutter_basics_1/pages/layout_styling/box_decoration_ui_page.dart';
import 'package:flutter_basics_1/pages/layout_styling/font_textstyle.dart';
import 'package:flutter_basics_1/pages/layout_styling/text_field_ui.dart';
import 'package:flutter_basics_1/pages/layout_styling/theme_and_color/theme_and_color.dart';
import 'package:flutter_basics_1/pages/sample_ui.dart';
import 'package:flutter_basics_1/pages/sample_ui_2.dart';
import 'package:flutter_basics_1/pages/selection_controlls.dart';
import 'package:flutter_basics_1/routes/page_address.dart';
import 'package:flutter_basics_1/routes/page_routes.dart';
import 'package:flutter_basics_1/widgets/button_and_icon.dart';
import 'package:flutter_basics_1/widgets/containers_and_padding.dart';
import 'package:flutter_basics_1/widgets/rows.dart';
import 'package:flutter_basics_1/widgets/stateful_test.dart';

/*
Platform  Firebase App Id
web       1:941317230359:web:17a4ab4c06d79aeffbf152
android   1:941317230359:android:09b970dbe0ca1fddfbf152
ios       1:941317230359:ios:dd73ca84b6fc00d2fbf152
macos     1:941317230359:ios:dd73ca84b6fc00d2fbf152
windows   1:941317230359:web:16305c4b69659ac1fbf152
 */
//
// > Task :sqflite_android:signingReport
// Variant: debugAndroidTest
// Config: debug
// Store: C:\Users\ORANGEBD\.android\debug.keystore
// Alias: AndroidDebugKey
// MD5: 6E:68:44:CD:0E:25:1A:B4:70:55:1F:C1:C2:56:8B:56
// SHA1: F7:F4:4E:A0:7E:C2:85:7F:4F:7F:3F:45:9A:11:1A:36:0C:40:7D:E2
// SHA-256: A0:53:2A:24:7E:DB:DD:FD:86:9A:25:69:6A:18:38:AC:04:23:A7:62:B0:33:81:E0:78:FE:D8:A9:A7:D8:75:22
// Valid until: Friday, November 26, 2055

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebasePushApi().initNotification();

  runApp(Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: PageAddress.HOME_PAGE,
      routes: PageRoutes.routes,
      navigatorKey: navigatorKey,
    );
  }
}
