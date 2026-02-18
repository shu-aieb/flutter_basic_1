import 'package:flutter/material.dart';
import 'package:flutter_basics_1/pages/code_quality/reusable_widget/reusable_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/reusable_widgets.dart';

class ReusableWidgetPage extends StatelessWidget {
  ReusableWidgetPage({super.key});

  final List<Map<String, dynamic>> imageCardInfo = [
    {
      'imageUrl':
          'https://plus.unsplash.com/premium_photo-1764286893674-026ba53cec92?q=80&w=327&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'title': 'Eiffel Tower',
      'subTitle': 'Paris, France',
      'isFavorite': false,
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1585506942812-e72b29cef752?q=80&w=428&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'title': 'Taj Mahal',
      'subTitle': 'Agra, India',
      'isFavorite': true,
    },
    {
      'imageUrl':
          'https://images.unsplash.com/flagged/photo-1552553030-837c9c2b0fac?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'title': 'The Great Wall',
      'subTitle': 'Huairou District, China',
      'isFavorite': false,
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1535051188811-c841ac77c80b?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'title': 'The London Bridge',
      'subTitle': 'London, UK',
      'isFavorite': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Reusable Widgets'),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                'Reusable - "Image Card" : ',
                style: GoogleFonts.deliusSwashCaps(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 240,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 5),

                itemCount: imageCardInfo.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ImageCard(
                      imageUrl: imageCardInfo[index]['imageUrl'],
                      title: imageCardInfo[index]['title'],
                      subTitle: imageCardInfo[index]['subTitle'],
                      isFavorite: imageCardInfo[index]['isFavorite'],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                'Reusable - "List Card" : ',
                style: GoogleFonts.deliusSwashCaps(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
            ),
            SizedBox(height: 5),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  FeatureListTile(
                    icon: Icons.person,
                    title: "Profile Settings",
                    sub: "Manage account",
                  ),
                  FeatureListTile(
                    icon: Icons.lock,
                    title: 'Privacy',
                    sub: "Change password",
                  ),
                  FeatureListTile(
                    icon: Icons.payment,
                    title: "Payment",
                    sub: 'Credit Card',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
