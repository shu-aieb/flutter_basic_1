import 'package:flutter/material.dart';
import 'package:flutter_basics_1/pages/materialpage/drawer/states.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: allStates.length + 1,
            itemBuilder: (context, index) {
              return index == 0
                  ? buildHeader(constraints.maxWidth * 0.1)
                  : buildMenuItem(index - 1, constraints.maxWidth * 0.06);
            },
          ),
        );
      },
    );
  }

  Widget buildHeader(double fontSize) => DrawerHeader(
    decoration: const BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.fitWidth,
        image: ExactAssetImage('assets/images/brazil.jpg'),
      ),
    ),
    child: Container(
      alignment: AlignmentDirectional.bottomStart,
      child: Text(
        'Bangladesh',
        maxLines: 1,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  Widget buildMenuItem(int index, double fontSize) => ListTile(
    leading: const Icon(Icons.location_city),
    title: Text(allStates[index], style: TextStyle(fontSize: fontSize)),
  );
}
