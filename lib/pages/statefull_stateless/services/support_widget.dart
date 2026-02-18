import 'dart:ui';

import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle headlineText(double size) {
    return TextStyle(
      color: Colors.black,
      fontSize: size,
      fontFamily: 'Poppins',
    );
  }

  static Widget clickableText(String text) {
    return Text(
      text,
      style: TextStyle(
        decoration: TextDecoration.underline,
        color: Color.fromARGB(123, 0, 0, 0),
        fontFamily: 'Poppins',
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static Widget subText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Color.fromARGB(123, 0, 0, 0),
        fontFamily: 'Poppins',
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static Widget countryClip(
    String txt, {
    required bool isSelect,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: isSelect ? Colors.black : Colors.black12,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Center(
          child: Text(
            txt,
            style: TextStyle(
              color: isSelect ? Colors.white : Color.fromARGB(96, 0, 0, 0),
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }
}

class LocationView extends StatelessWidget {
  const LocationView({
    super.key,
    required this.imageHeight,
    required this.imageWidth,
    required this.totalHeight,
    required this.countryName,
    required this.continentName,
    required this.imageSrc,
    required this.onTap,
  });

  final double imageHeight;
  final double imageWidth;
  final double totalHeight;
  final String imageSrc;
  final String countryName;
  final String continentName;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: SizedBox(
          height: imageHeight,
          width: imageWidth,
          child: Stack(
            children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    imageSrc,
                    height: imageHeight,
                    width: imageWidth,
                    fit: BoxFit.cover,
                    // gaplessPlayback: true,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: imageHeight * 0.5,
                  width: imageWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(0, 0, 0, 0),
                        Color.fromARGB(150, 0, 0, 0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Container(
                height: imageHeight,
                width: imageWidth,
                padding: EdgeInsets.only(
                  left: 20,
                  bottom: 20,
                  right: 20,
                  top: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          countryName,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          continentName,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: totalHeight * 0.06,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.only(right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'See More',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum Pages { home, favourite, profile, cart }

class BottomNavBar extends StatefulWidget {
  BottomNavBar({super.key, required this.selectedPage});

  Pages selectedPage;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 10, right: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(60),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: _iconWithBg(
              icon: Icons.home_outlined,
              isSelected: widget.selectedPage == Pages.home,
              onTap: () {
                setState(() {
                  widget.selectedPage = Pages.home;
                });
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: _iconWithBg(
              icon: Icons.favorite_outline,
              isSelected: widget.selectedPage == Pages.favourite,
              onTap: () {
                setState(() {
                  widget.selectedPage = Pages.favourite;
                });
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: _iconWithBg(
              icon: Icons.person_outline,
              isSelected: widget.selectedPage == Pages.profile,
              onTap: () {
                setState(() {
                  widget.selectedPage = Pages.profile;
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: _iconWithBg(
              icon: Icons.shopping_cart_outlined,
              isSelected: widget.selectedPage == Pages.cart,
              onTap: () {
                setState(() {
                  widget.selectedPage = Pages.cart;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconWithBg({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.black26,
          size: 30,
        ),
      ),
    );
  }
}
