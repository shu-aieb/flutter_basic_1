import 'package:flutter/material.dart';
import 'package:flutter_basics_1/pages/materialpage/custom_navigation_bar.dart';
import 'package:flutter_basics_1/pages/materialpage/drawer/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.selectedIndex,
    required this.onItemTap,
  });

  final int selectedIndex;
  final void Function(int) onItemTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade200,
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: selectedIndex,
        onItemTap: onItemTap,
      ),
      body: Center(child: Icon(Icons.home, size: 50)),
      drawer: Drawer(child: DrawerWidget()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: CircleBorder(),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
