import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar myAppBar({required String title}) {
  return AppBar(
    title: Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(
        'Create Account',
        style: GoogleFonts.playwritePt(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
  );
}
