import 'package:flutter/material.dart';

class BasicWidget4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text("Padding, Margin & Align")),
      body: Column(
        children: [
          // Example of Margin (Space outside the widget)
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ), // Space inside
            color: Colors.white,
            child: Text("This box has 20px margin outside and padding inside."),
          ),

          // Example of Alignment within a Container
          Container(
            height: 150,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.blue[100],
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Top Left"),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Center",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Bottom Right"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
