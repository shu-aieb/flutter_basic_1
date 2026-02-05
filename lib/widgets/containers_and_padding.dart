import 'package:flutter/material.dart';

class ContainerAndPadding extends StatelessWidget {
  const ContainerAndPadding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu, color: Colors.white),
        title: Text(
          'Container & Padding Example',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: 'DeliusSwash',
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red.shade600,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 30, 50, 80),
            margin: EdgeInsets.all(20),
            color: Colors.red.shade200,
            child: Text('Container Example'),
          ),
          Padding(padding: EdgeInsets.all(30), child: Text('Padding Example')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: CircleBorder(),
        backgroundColor: Colors.red.shade600,
        child: Icon(Icons.alarm, color: Colors.white),
      ),
    );
  }
}
