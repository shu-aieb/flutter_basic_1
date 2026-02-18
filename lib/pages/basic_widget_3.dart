// 3_row_column.dart
import 'package:flutter/material.dart';

class BasicWidget3 extends StatelessWidget {
  const BasicWidget3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Row & Column"), centerTitle: true),
      body: Column(
        children: [
          // Header Row
          Container(
            height: 100,
            color: Colors.blueGrey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.menu, color: Colors.white),
                Text(
                  "Dashboard",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                Icon(Icons.notifications, color: Colors.white),
              ],
            ),
          ),

          SizedBox(height: 20),

          // Feature Rows (Simulating a list)
          featureRow(Icons.person, "Profile Settings", "Manage account"),
          featureRow(Icons.lock, "Privacy", "Change password"),
          featureRow(Icons.payment, "Payments", "Credit cards"),
        ],
      ),
    );
  }

  Widget featureRow(IconData icon, String title, String sub) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Icon(icon, size: 40, color: Colors.blue),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(sub, style: TextStyle(color: Colors.grey)),
            ],
          ),
          Spacer(), // Pushes the arrow to the far right
          Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}
