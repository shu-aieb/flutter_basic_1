import 'package:flutter/material.dart';
import 'package:flutter_basics_1/pages/materialpage/home_screen.dart';
import 'package:flutter_basics_1/pages/materialpage/profile_screen.dart';
import 'package:flutter_basics_1/pages/materialpage/settings_screen.dart';

class MaterialAppScaffold extends StatefulWidget {
  const MaterialAppScaffold({super.key});

  @override
  State<MaterialAppScaffold> createState() => _MaterialAppScaffoldState();
}

class _MaterialAppScaffoldState extends State<MaterialAppScaffold> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  // static const List<Widget> _screens = [
  //   HomeScreen(),
  //   ProfileScreen(),
  //   SettingsScreen(),
  // ];

  final List<String> _titles = [
    'Home Screen',
    'Profile Screen',
    'Setting Screen',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _setScreen() {
    switch (_selectedIndex) {
      case 0:
        return HomeScreen(
          selectedIndex: _selectedIndex,
          onItemTap: _onItemTapped,
        );
      case 1:
        return ProfileScreen(
          selectedIndex: _selectedIndex,
          onItemTap: _onItemTapped,
        );
      case 2:
        return SettingsScreen(
          selectedIndex: _selectedIndex,
          onItemTap: _onItemTapped,
        );
      default:
        return HomeScreen(
          selectedIndex: _selectedIndex,
          onItemTap: _onItemTapped,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: _setScreen());

    // return Scaffold(
    //   appBar: AppBar(title: Text(_titles[_selectedIndex]), centerTitle: true),
    //   body: _screens[_selectedIndex],
    //   bottomNavigationBar: NavigationBar(
    //     selectedIndex: _selectedIndex,
    //     onDestinationSelected: _onItemTapped,
    //     destinations: const [
    //       NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
    //       NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
    //       NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
    //     ],
    //   ),
    // );
  }
}
