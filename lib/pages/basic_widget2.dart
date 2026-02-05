import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BasicWidget2 extends StatelessWidget {
  const BasicWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Container, SizedBox',
          style: GoogleFonts.mochiyPopPOne(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 6,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black26,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Circle',
                  style: GoogleFonts.deliusSwashCaps(
                    fontSize: 20,
                    color: Colors.deepOrange.shade900,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
              height: 80,
              width: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  'Gradient Box',
                  style: GoogleFonts.aBeeZee(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: 100,
              width: 150,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black, width: 3),
              ),
              child: Center(
                child: Text('Border Box', style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: 30),
            _buildSectionTitle('1. Asymmetric Borders & Radius'),
            Center(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: 100,
                  minWidth: 100,
                  maxWidth: 200,
                ),
                transform: Matrix4.rotationZ(0.1)..rotateX(0.2),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(5, 5),
                      blurRadius: 5,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  "Rotated\nBox",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
