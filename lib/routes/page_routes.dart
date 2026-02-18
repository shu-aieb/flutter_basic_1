import 'package:flutter/cupertino.dart';
import 'package:flutter_basics_1/home/home.dart';
import 'package:flutter_basics_1/pages/basic_widget2.dart';
import 'package:flutter_basics_1/pages/basic_widget_1.dart';
import 'package:flutter_basics_1/pages/basic_widget_3.dart';
import 'package:flutter_basics_1/pages/basic_widget_4.dart';
import 'package:flutter_basics_1/pages/form_and_validation/complete/personal_info_screen.dart';
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

import '../pages/code_quality/reusable_widget/reusable_widget_page.dart';
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
  };
}
