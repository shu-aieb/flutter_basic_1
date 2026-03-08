import 'package:flutter/cupertino.dart';
import 'package:flutter_basics_1/firebase/cloud_store/pages/firestore_crud_page.dart';
import 'package:flutter_basics_1/firebase/firebase_storage/cloud_vault_screen.dart';
import 'package:flutter_basics_1/firebase/push_notification/pages/notification_page.dart';
import 'package:flutter_basics_1/firebase/realtime_database/page/auction_screen.dart';
import 'package:flutter_basics_1/firebase/wrapper.dart';
import 'package:flutter_basics_1/home/home.dart';
import 'package:flutter_basics_1/navigation/bottom_navigation.dart';
import 'package:flutter_basics_1/pages/animations/explicit_animation_page.dart';
import 'package:flutter_basics_1/pages/animations/implicit_animations_page.dart';
import 'package:flutter_basics_1/pages/basic_widget2.dart';
import 'package:flutter_basics_1/pages/basic_widget_1.dart';
import 'package:flutter_basics_1/pages/basic_widget_3.dart';
import 'package:flutter_basics_1/pages/basic_widget_4.dart';
import 'package:flutter_basics_1/pages/form_and_validation/complete/personal_info_screen.dart';
import 'package:flutter_basics_1/pages/layout/gridview.dart';
import 'package:flutter_basics_1/pages/layout_styling/all_buttons_page.dart';
import 'package:flutter_basics_1/pages/layout_styling/box_decoration_ui_page.dart';
import 'package:flutter_basics_1/pages/layout_styling/font_textstyle.dart';
import 'package:flutter_basics_1/pages/layout_styling/text_field_ui.dart';
import 'package:flutter_basics_1/pages/layout_styling/theme_and_color/theme_and_color_with_animation.dart';
import 'package:flutter_basics_1/pages/materialpage/material_app_scaffold.dart';
import 'package:flutter_basics_1/pages/statefull_stateless/pages/home.dart';
import 'package:flutter_basics_1/routes/page_address.dart';
import 'package:flutter_basics_1/sqflite_note_app/screens/notes_screen.dart';
import 'package:path/path.dart';

import '../navigation/navigation_drawer.dart';
import '../pages/animations/custom_animation.dart';
import '../pages/animations/hero_animations.dart';
import '../pages/code_quality/reusable_widget/reusable_widget_page.dart';
import '../pages/device_features/camera_page.dart';
import '../pages/selection_controlls.dart';

class PageRoutes {
  static Map<String, WidgetBuilder> routes = {
    PageAddress.TEXT_ICON_IMAGE_UI: (context) => BasicWidget1(),
    PageAddress.HOME_PAGE: (context) => HomePage(),
    PageAddress.CONTAINER_SIZED_BOX: (context) => BasicWidget2(),
    PageAddress.ROW_COLUMN: (context) => BasicWidget3(),
    PageAddress.PADDING_MARGIN: (context) => BasicWidget4(),
    PageAddress.STATEFUL_TEST: (context) => Home(),
    PageAddress.MATERIAL_APP_SCAFFOLD: (context) =>
        MaterialAppScaffold(), //NotesScreen(),
    PageAddress.BOX_DECORATION_UI_PAGE: (context) => BoxDecorationUIPage(),
    PageAddress.COLOR_THEME: (context) => ThemeAndColorWithAnimation(),
    PageAddress.FONT_TEXT_STYLE: (context) => FontTextStyle(),
    PageAddress.TEXTFIELD_TEXTFIELD_FORM: (context) => TextFieldUIPage(),
    PageAddress.BUTTONS: (context) => AllButtonsPage(),
    PageAddress.CHECKBOX_RADIO_SWITCH: (context) => SelectionControlsPage(),
    PageAddress.FORM_VALIDATION: (context) => PersonalInfoScreen(),
    PageAddress.REUSABLE_WIDGET_PAGE: (context) => ReusableWidgetPage(),
    PageAddress.FIREBASE_AUTH: (context) => Wrapper(),
    PageAddress.CLOUD_FIRESTORE: (context) => FirestoreCrudPage(),
    PageAddress.REALTIME_DATABASE: (context) => AuctionScreen(),
    PageAddress.CLOUD_STORAGE: (context) => CloudVaultScreen(),
    PageAddress.NOTIFICATION: (context) => NotificationPage(),

    PageAddress.EXPLECIT_ANIMATION: (context) => ExplicitAnimationPage(),
    PageAddress.IMPLICIT_ANIMATION: (context) => ImplicitAnimationsPage(),
    PageAddress.CUSTOM_ANIMATION: (context) => CustomPainterPage(),
    PageAddress.HERO_ANIMATION: (context) => HeroAnimationPage(),

    PageAddress.LAYOUT_GRIDVIEW: (context) => const GridViewPage(),
    PageAddress.NAVIGATION_DRAWER: (context) => NavigationDrawerPage(),
    PageAddress.BOTTOM_NAVIGATION_BAR: (context) => BottomNavigationPage(),

    PageAddress.CAMERA_PAGE: (context) => CameraPage(),
  };
}
