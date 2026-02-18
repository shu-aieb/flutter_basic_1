import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


AppBar myAppBar({required String title}) {
  return AppBar(
    title: Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
      child: Text(
        title,
        style: GoogleFonts.playwritePt(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
  );
}
