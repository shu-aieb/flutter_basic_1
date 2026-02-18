import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';

import 'my_colors.dart';
import 'my_sizes.dart';

class MyStyles {
  static final appBarTextStyle = GoogleFonts.mochiyPopPOne(
    fontSize: MyFontSize.superLarge,
    fontWeight: FontWeight.bold,
    color: MyColors.primaryColor,
  );

  static final headingTextStyle = GoogleFonts.mochiyPopPOne(
    fontSize: MyFontSize.large,
    fontWeight: FontWeight.bold,
    color: MyColors.primaryColor,
  );

  static final smallTextStyle = GoogleFonts.poppins(
    fontSize: MyFontSize.small,
    fontWeight: FontWeight.w500,
    color: MyColors.secondaryColor,
  );

  static final textButtonStyle = GoogleFonts.mochiyPopPOne(
    fontSize: MyFontSize.medium,
    fontWeight: FontWeight.normal,
    color: MyColors.secondaryColor,
  );
}
