import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BasicWidget1 extends StatelessWidget {
  const BasicWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Text, Icon, Image',
          style: GoogleFonts.mochiyPopPOne(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 6,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1689037676450-aabec64bafa7?q=80&w=674&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Silicon Valley',
              style: GoogleFonts.deliusSwashCaps(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Text(
              'The Tech capital of the world',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 40,
              children: [
                Icon(Icons.favorite, color: Colors.red, size: 40),
                Icon(Icons.code, color: Colors.blue, size: 40),
                Icon(Icons.flutter_dash, color: Colors.green, size: 40),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customLocationCard(
                  imageUrl:
                      'https://plus.unsplash.com/premium_photo-1764286893674-026ba53cec92?q=80&w=327&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  title: 'Eiffel Tower',
                  subTitle: 'Paris, France',
                  isFavorite: false,
                ),
                customLocationCard(
                  imageUrl:
                      'https://images.unsplash.com/photo-1585506942812-e72b29cef752?q=80&w=428&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  title: 'Taj Mahal',
                  subTitle: 'Agra, India',
                  isFavorite: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget customLocationCard({
    required String imageUrl,
    required String title,
    required String subTitle,
    required bool isFavorite,
  }) {
    return SizedBox(
      height: 240,
      width: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Image.network(imageUrl, height: 240, width: 150, fit: BoxFit.cover),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black54],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      subTitle,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_outline,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
