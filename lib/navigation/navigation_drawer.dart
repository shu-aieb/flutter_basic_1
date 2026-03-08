import 'package:flutter/material.dart';

class NavigationDrawerPage extends StatelessWidget {
  NavigationDrawerPage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Navigation Drawer'),
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(Icons.menu),
        ),
      ),
      body: Center(child: Text('Navigation Drawer Page')),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20),
              FlutterLogo(size: 100),
              const SizedBox(height: 35),
              Text(
                'App Title',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              ListTile(title: Text('Home'), leading: Icon(Icons.home)),
              ListTile(title: Text('Settings'), leading: Icon(Icons.settings)),
              ListTile(title: Text('Profile'), leading: Icon(Icons.person)),
              ListTile(title: Text('Help'), leading: Icon(Icons.help)),
              Spacer(),
              ListTile(title: Text('Logout'), leading: Icon(Icons.logout)),
            ],
          ),
        ),
      ),
    );
  }
}
