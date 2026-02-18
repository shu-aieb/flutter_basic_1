import 'package:flutter/material.dart';

import 'custom_navigation_bar.dart';
import 'drawer/drawer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
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
        title: Text('Profile Screen'),
        centerTitle: true,
        backgroundColor: Colors.red.shade200,
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: selectedIndex,
        onItemTap: onItemTap,
      ),
      body: Center(child: Icon(Icons.person, size: 50)),
      drawer: Drawer(child: DrawerWidget()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: CircleBorder(),
        backgroundColor: Colors.red.shade800,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }
}
