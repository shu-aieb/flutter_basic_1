import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StateFulTest1 extends StatefulWidget {
  const StateFulTest1({super.key});

  @override
  State<StateFulTest1> createState() => _StateFulTest1State();
}

class _StateFulTest1State extends State<StateFulTest1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stateful Widget Example'),
        centerTitle: true,
        backgroundColor: Colors.red.shade600,
      ),
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            Fluttertoast.showToast(
              msg: "Button Pressed!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          },
          child: Text('Press Me'),
        ),
      ),
    );
  }
}
