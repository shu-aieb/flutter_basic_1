import 'package:flutter/material.dart';
import 'package:flutter_basics_1/home/section.dart';
import 'package:flutter_basics_1/home/topic.dart';
import 'package:flutter_basics_1/routes/page_address.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<Section> topic_dir = [
    Section(
      title: 'Basic UI Widgets',
      topics: [
        Topic(
          title: 'Text, Icon, Image',
          subTitle: 'Page',
          pageRoute: PageAddress.TEXT_ICON_IMAGE_UI,
        ),
        Topic(
          title: 'Container, SizedBox',
          subTitle: 'Page',
          pageRoute: PageAddress.CONTAINER_SIZED_BOX,
        ),
        Topic(
          title: 'Row, Column',
          subTitle: 'Page',
          pageRoute: PageAddress.ROW_COLUMN,
        ),
        Topic(
          title: 'Padding, Margin, Alignment',
          subTitle: 'Page',
          pageRoute: PageAddress.PADDING_MARGIN,
        ),
      ],
    ),
    Section(
      title: 'Widgets Overview',
      topics: [
        Topic(
          title: 'Stateless vs Stateful widgets',
          subTitle: 'Page',
          pageRoute: PageAddress.STATEFUL_TEST,
        ),
        Topic(
          title: 'MaterialApp & Scaffold',
          subTitle: 'Page',
          pageRoute: PageAddress.MATERIAL_APP_SCAFFOLD,
        ),
      ],
    ),
    Section(
      title: 'Layout & Styling',
      topics: [
        Topic(
          title: 'BoxDecoration',
          subTitle: 'Page',
          pageRoute: PageAddress.BOX_DECORATION_UI_PAGE,
        ),
        Topic(
          title: 'Colors & Theme',
          subTitle: 'Page',
          pageRoute: PageAddress.COLOR_THEME,
        ),
        Topic(
          title: 'Font & TextStyle',
          subTitle: 'Page',
          pageRoute: PageAddress.FONT_TEXT_STYLE,
        ),
      ],
    ),
    Section(
      title: 'Input Widget',
      topics: [
        Topic(
          title: 'TextField & TextFieldForm',
          subTitle: 'Page',
          pageRoute: PageAddress.TEXTFIELD_TEXTFIELD_FORM,
        ),
        Topic(
          title: 'Buttons',
          subTitle: 'Page',
          pageRoute: PageAddress.BUTTONS,
        ),
        Topic(
          title: 'Checkbox, Radio, Switch',
          subTitle: 'Page',
          pageRoute: PageAddress.CHECKBOX_RADIO_SWITCH,
        ),
      ],
    ),
    Section(
      title: 'Forms & Validation',
      topics: [
        Topic(
          title: 'Form Widget & Validation',
          subTitle: 'Page',
          pageRoute: PageAddress.FORM_VALIDATION,
        ),
      ],
    ),
    Section(
      title: 'Navigation & Routing',
      topics: [
        Topic(
          title: 'Navigator Push & Pop',
          subTitle: 'Page',
          pageRoute: PageAddress.FORM_VALIDATION,
        ),
      ],
    ),
    Section(
      title: 'Code Quality',
      topics: [
        Topic(
          title: 'Reusable Widgets',
          subTitle: 'Page',
          pageRoute: PageAddress.REUSABLE_WIDGET_PAGE,
        ),
      ],
    ),
    Section(
      title: 'Firebase Services',
      topics: [
        Topic(
          title: 'Firebase Authentication',
          subTitle: 'Page',
          pageRoute: PageAddress.FIREBASE_AUTH,
        ),
        Topic(
          title: 'Cloud Firestore (CRUD)',
          subTitle: 'Page',
          pageRoute: PageAddress.CLOUD_FIRESTORE,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            floating: false,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Topics Covered',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              background: Image.network(
                'https://picsum.photos/id/1/800/600',
                fit: BoxFit.cover,
                color: Colors.black45,
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),

          for (var section in topic_dir) ...[
            SliverPersistentHeader(
              pinned: true,
              delegate: _SectionHeaderDelegate(title: section.title),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ListTile(
                    onTap: () {
                      if (section.topics[index].pageRoute != null) {
                        Navigator.pushNamed(
                          context,
                          section.topics[index].pageRoute!,
                        );
                      }
                    },

                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    title: Text(
                      section.topics[index].title,
                      style: GoogleFonts.deliusSwashCaps(
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      'Type : ${section.topics[index].subTitle}',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    trailing: Icon(Icons.forward, color: Colors.orange),
                  );
                },
                childCount: section.topics.length, // Long list
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;

  _SectionHeaderDelegate({required this.title});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  @override
  double get maxExtent => 60.0;

  @override
  double get minExtent => 60.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
