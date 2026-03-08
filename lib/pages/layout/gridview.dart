import 'package:flutter/material.dart';

class GridViewPage extends StatelessWidget {
  const GridViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gridview')),
      body: GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 1 / 1.5,
        ),
        children: [
          Image.asset('assets/images/bali.jpg', fit: BoxFit.cover),
          Image.asset('assets/images/brazil.jpg', fit: BoxFit.cover),
          Image.asset('assets/images/eiffel-tower.jpg', fit: BoxFit.cover),
          Image.asset('assets/images/france.jpg', fit: BoxFit.cover),
          Image.asset('assets/images/girl.jpg', fit: BoxFit.cover),
          Image.asset('assets/images/louvre-museum.jpg', fit: BoxFit.cover),
          Image.asset('assets/images/bali.jpg', fit: BoxFit.cover),
          Image.asset('assets/images/brazil.jpg', fit: BoxFit.cover),
          Image.asset('assets/images/eiffel-tower.jpg', fit: BoxFit.cover),
          Image.asset('assets/images/france.jpg', fit: BoxFit.cover),
          Image.asset('assets/images/girl.jpg', fit: BoxFit.cover),
          Image.asset('assets/images/louvre-museum.jpg', fit: BoxFit.cover),
          Image.asset('assets/images/bali.jpg', fit: BoxFit.cover),
          Image.asset('assets/images/brazil.jpg', fit: BoxFit.cover),
          Image.asset('assets/images/eiffel-tower.jpg', fit: BoxFit.cover),
          Image.asset('assets/images/france.jpg', fit: BoxFit.cover),
          Image.asset('assets/images/girl.jpg', fit: BoxFit.cover),
          Image.asset('assets/images/louvre-museum.jpg', fit: BoxFit.cover),
        ],
      ),
    );
  }
}
