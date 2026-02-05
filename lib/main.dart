import 'package:flutter/material.dart';
import 'package:flutter_basics_1/pages/advanced_layout/custom_scroll/custom_scroll_show_case.dart';
import 'package:flutter_basics_1/pages/advanced_layout/list_grid_showcase.dart';
import 'package:flutter_basics_1/pages/advanced_layout/sliver_mastery.dart';
import 'package:flutter_basics_1/pages/basic_widget2.dart';
import 'package:flutter_basics_1/pages/basic_widget_1.dart';
import 'package:flutter_basics_1/pages/basic_widget_3.dart';
import 'package:flutter_basics_1/pages/basic_widget_4.dart';
import 'package:flutter_basics_1/pages/form_and_validation/complete/personal_info_screen.dart';
import 'package:flutter_basics_1/pages/form_and_validation/my_form.dart';
import 'package:flutter_basics_1/pages/layout_styling/all_buttons_page.dart';
import 'package:flutter_basics_1/pages/layout_styling/box_decoration_ui_page.dart';
import 'package:flutter_basics_1/pages/layout_styling/font_textstyle.dart';
import 'package:flutter_basics_1/pages/layout_styling/text_field_ui.dart';
import 'package:flutter_basics_1/pages/layout_styling/theme_and_color/theme_and_color.dart';
import 'package:flutter_basics_1/pages/sample_ui.dart';
import 'package:flutter_basics_1/pages/sample_ui_2.dart';
import 'package:flutter_basics_1/pages/selection_controlls.dart';
import 'package:flutter_basics_1/widgets/button_and_icon.dart';
import 'package:flutter_basics_1/widgets/containers_and_padding.dart';
import 'package:flutter_basics_1/widgets/rows.dart';
import 'package:flutter_basics_1/widgets/stateful_test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(home: Home()));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SliverMasteryPage());
  }
}
