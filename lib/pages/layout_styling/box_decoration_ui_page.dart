import 'dart:ui';

import 'package:flutter/material.dart';

enum MyColors {
  freePlan(
    cardBgColor: LinearGradient(
      colors: [Color(0xFFBDBDBD), Color(0xFF757575)],
      end: Alignment.bottomRight,
    ),
    titleColor: Colors.white,
    subtitleColor: Colors.white70,
    iconColor: Colors.white,
    iconBgColor: Color(0xFFCCCCCC),
    cardShadowColor: Color(0xFFB4B4B4),
  ),
  paidPlan(
    cardBgColor: LinearGradient(
      colors: [Colors.blueAccent, Colors.deepPurpleAccent],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    titleColor: Colors.white,
    subtitleColor: Colors.white70,
    iconColor: Colors.white,
    iconBgColor: Color(0xBBA2B6FF),
    cardShadowColor: Color(0xFFA2B6FF),
  ),
  ultimatePlan(
    cardBgColor: LinearGradient(
      colors: [
        Color(0xFF8E24AA), // Royal Purple
        Color(0xFFD81B60), // Magenta
        Color(0xFFFFB300), // Gold hint
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    titleColor: Colors.white,
    subtitleColor: Colors.white70,
    iconColor: Colors.white,
    iconBgColor: Color(0x99D445FB),
    cardShadowColor: Color(0x99FF5E9E),
  );

  final Gradient cardBgColor;
  final Color titleColor;
  final Color subtitleColor;
  final Color iconColor;
  final Color iconBgColor;
  final Color cardShadowColor;

  const MyColors({
    required this.cardBgColor,
    required this.titleColor,
    required this.subtitleColor,
    required this.iconColor,
    required this.iconBgColor,
    required this.cardShadowColor,
  });
}

class BoxDecorationUIPage extends StatefulWidget {
  const BoxDecorationUIPage({super.key});

  @override
  State<BoxDecorationUIPage> createState() => _BoxDecorationUIPageState();
}

class _BoxDecorationUIPageState extends State<BoxDecorationUIPage> {
  late MyColors selectedPlan;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedPlan = MyColors.freePlan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Clean off-white background
      appBar: AppBar(
        title: Text("Choose Your Plan", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // INTRO TEXT
            Text(
              "Unlock features with the right plan.",
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
            SizedBox(height: 30),

            myCard(
              MyColors.freePlan,
              "Free Plan",
              "Basic access only",
              Icons.money_off,
              selectedPlan == MyColors.freePlan,
              () => setState(() {
                selectedPlan = MyColors.freePlan;
              }),
            ),
            SizedBox(height: 20),
            myCard(
              MyColors.paidPlan,
              "Pro Member",
              "\$9.99 / month",
              Icons.star,
              selectedPlan == MyColors.paidPlan,
              () => setState(() {
                selectedPlan = MyColors.paidPlan;
              }),
            ),
            SizedBox(height: 20),
            myCard(
              MyColors.ultimatePlan,
              "Ultimate Access",
              "Unlock everything + Priority Support.",
              Icons.diamond,
              selectedPlan == MyColors.ultimatePlan,
              () => setState(() {
                selectedPlan = MyColors.ultimatePlan;
              }),
            ),
            SizedBox(height: 20),

            // // 1. THE BASIC CARD (Clean, Border-focused)
            // // Shows mastery of: Borders, BorderRadius, Simple Color
            // Container(
            //   width: double.infinity,
            //   padding: EdgeInsets.all(20),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(15),
            //     border: Border.all(
            //       color: Colors.grey.shade300, // Subtle border
            //       width: 2,
            //     ),
            //   ),
            //   child: Row(
            //     children: [
            //       Container(
            //         padding: EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //           color: Colors.grey[100],
            //           shape: BoxShape.circle, // Circular icon background
            //         ),
            //         child: Icon(Icons.money_off, color: Colors.grey[700]),
            //       ),
            //       SizedBox(width: 15),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             "Free Plan",
            //             style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 18,
            //             ),
            //           ),
            //           Text(
            //             "Basic access only",
            //             style: TextStyle(color: Colors.grey),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            //
            // SizedBox(height: 20),
            //
            // // 2. THE PRO CARD (Gradient-focused)
            // // Shows mastery of: LinearGradient, BoxShadow (Soft)
            // Container(
            //   width: double.infinity,
            //   padding: EdgeInsets.all(20),
            //   decoration: BoxDecoration(
            //     // Gradient makes it look premium
            //     gradient: LinearGradient(
            //       colors: [Colors.blueAccent, Colors.blue[800]!],
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //     ),
            //     borderRadius: BorderRadius.circular(15),
            //     // Soft shadow to lift it off the screen
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.blue.withValues(alpha: 0.4),
            //         blurRadius: 15,
            //         offset: Offset(0, 8),
            //       ),
            //     ],
            //   ),
            //   child: Row(
            //     children: [
            //       Container(
            //         padding: EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //           color: Colors.blue[100],
            //           shape: BoxShape.circle, // Circular icon background
            //         ),
            //         child: Icon(Icons.star, color: Colors.blue[700]),
            //       ),
            //       SizedBox(width: 15),
            //
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             "Pro Member",
            //             style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 18,
            //               color: Colors.white,
            //             ),
            //           ),
            //           Text(
            //             "\$9.99 / month",
            //             style: TextStyle(color: Colors.white70),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            //
            // SizedBox(height: 20),
            //
            // // 3. THE ULTIMATE CARD (Image & Blend Mode)
            // // Shows mastery of: DecorationImage, ColorFilter, Complex Borders
            // Container(
            //   height: 140, // Taller card
            //   width: double.infinity,
            //   padding: EdgeInsets.all(20),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(20),
            //     // Glowing border effect
            //     border: Border.all(color: Colors.amber, width: 2),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.amber.withOpacity(0.3),
            //         blurRadius: 20,
            //         spreadRadius: 2,
            //       ),
            //     ],
            //     // Background Image with a dark filter so text is readable
            //     image: DecorationImage(
            //       image: NetworkImage("https://picsum.photos/id/43/400/200"),
            //       fit: BoxFit.cover,
            //       colorFilter: ColorFilter.mode(
            //         Colors.black.withOpacity(0.7),
            //         BlendMode.darken,
            //       ),
            //     ),
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Row(
            //         children: [
            //           Icon(Icons.diamond, color: Colors.amber),
            //           SizedBox(width: 10),
            //           Text(
            //             "ULTIMATE ACCESS",
            //             style: TextStyle(
            //               color: Colors.amber,
            //               fontWeight: FontWeight.bold,
            //               letterSpacing: 2,
            //             ),
            //           ),
            //         ],
            //       ),
            //       SizedBox(height: 10),
            //       Text(
            //         "Unlock everything + Priority Support.",
            //         style: TextStyle(color: Colors.white),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 40),

            GestureDetector(
              onTap: () {
                var snackBar = SnackBar(
                  content: Text(
                    selectedPlan == MyColors.freePlan
                        ? 'Free Plan Selected'
                        : selectedPlan == MyColors.paidPlan
                        ? 'Paid Plan Selected'
                        : 'Ultimate Plan Selected',
                  ),
                  duration: const Duration(milliseconds: 2000),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget myCard(
    MyColors myColor,
    String title,
    String subtitle,
    IconData icon,
    bool isSelected,
    Function onTap,
  ) => GestureDetector(
    onTap: () => onTap(),
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        // Gradient makes it look premium
        gradient: isSelected ? myColor.cardBgColor : null,
        borderRadius: BorderRadius.circular(15),
        border: isSelected
            ? Border.all(color: Colors.transparent, width: 2)
            : Border.all(
                color: Colors.grey.shade300, // Subtle border
                width: 2,
              ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: myColor.cardShadowColor,
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSelected ? myColor.iconBgColor : Colors.grey[100],
              shape: BoxShape.circle, // Circular icon background
            ),
            child: Icon(
              icon,
              color: isSelected ? myColor.iconColor : Colors.grey[700],
            ),
          ),
          SizedBox(width: 15),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: isSelected ? myColor.titleColor : Colors.black87,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: isSelected ? myColor.subtitleColor : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
