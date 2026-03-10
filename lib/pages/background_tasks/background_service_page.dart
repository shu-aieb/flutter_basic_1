import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class BackgroundServicePage extends StatelessWidget {
  BackgroundServicePage({super.key});

  final service = FlutterBackgroundService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Background Service')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            service.startService();
          },
          child: Text('Start Background Task'),
        ),
      ),
    );
  }
}
