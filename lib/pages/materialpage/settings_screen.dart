import 'package:flutter/material.dart';

import 'custom_navigation_bar.dart';
import 'drawer/drawer.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
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
        title: Text('Settings Screen'),
        centerTitle: true,
        backgroundColor: Colors.green.shade200,
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: selectedIndex,
        onItemTap: onItemTap,
      ),
      body: Center(child: Icon(Icons.settings, size: 50)),
      drawer: Drawer(child: DrawerWidget()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: CircleBorder(),
        backgroundColor: Colors.green.shade800,
        foregroundColor: Colors.white,
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
