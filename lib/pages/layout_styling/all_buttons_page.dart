import 'package:flutter/material.dart';

class AllButtonsPage extends StatefulWidget {
  const AllButtonsPage({super.key});

  @override
  _AllButtonsPageState createState() => _AllButtonsPageState();
}

class _AllButtonsPageState extends State<AllButtonsPage> {
  // State for Dropdown
  String dropdownValue = 'Option 1';

  // State for Toggle Buttons (Bold, Italic, Underline)
  final List<bool> _selections = [false, true, false];

  // State for Loading Button
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Button Gallery")),
      // A Floating Action Button (FAB) is usually standard here
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.amber,
        tooltip: "Floating Action Button",
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header("Material Buttons"),
            Wrap(
              spacing: 10, // Horizontal space
              runSpacing: 10, // Vertical space
              alignment: WrapAlignment.center,
              children: [
                // A. ELEVATED BUTTON (With Icon & Stadium Shape)
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.upload, size: 18),
                  label: Text("Elevated"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    foregroundColor: Colors.white,
                    shape: StadiumBorder(), // Fully rounded ends
                    elevation: 5,
                  ),
                ),

                // B. OUTLINED BUTTON (Bordered)
                OutlinedButton(
                  onPressed: () {},
                  child: Text("Outlined"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue.shade800,
                    side: BorderSide(color: Colors.blue[800]!, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                // C. TEXT BUTTON (Flat)
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  child: Text("Text Button"),
                ),
              ],
            ),

            Divider(height: 30),

            _header("States & Interaction"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // A. DISABLED BUTTON
                // To disable a button in Flutter, you set onPressed to NULL.
                ElevatedButton(
                  onPressed: null, // <--- THIS IS KEY
                  child: Text("Disabled"),
                ),

                // B. LOADING BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  onPressed: () async {
                    setState(() => _isLoading = true);
                    await Future.delayed(Duration(seconds: 2));
                    setState(() => _isLoading = false);
                  },
                  child: _isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          "Tap to Load",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ],
            ),

            Divider(height: 30),

            _header("Selection & Inputs"),

            // A. TOGGLE BUTTONS (Segmented Control)
            Center(
              child: ToggleButtons(
                children: [
                  Icon(Icons.format_bold),
                  Icon(Icons.format_italic),
                  Icon(Icons.format_underline),
                ],
                isSelected: _selections,
                onPressed: (int index) {
                  setState(() {
                    _selections[index] = !_selections[index];
                  });
                },
                borderRadius: BorderRadius.circular(10),
                selectedColor: Colors.yellow,
                fillColor: Colors.blueAccent,
                color: Colors.black26,
              ),
            ),

            SizedBox(height: 15),

            // B. DROPDOWN BUTTON
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: dropdownValue,
                  isExpanded: true, // Fills width
                  icon: Icon(Icons.arrow_drop_down_circle, color: Colors.blue),
                  items:
                      <String>[
                        'Option 1',
                        'Option 2',
                        'Option 3',
                        'Option 4',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                ),
              ),
            ),

            Divider(height: 30),

            _header("4. Custom Gradient Button (InkWell)"),
            // This demonstrates how to make ANY container a button with Ripple effect
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Custom Button Pressed!")),
                  );
                },
                borderRadius: BorderRadius.circular(
                  30,
                ), // Matches container radius for splash
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orange, Colors.redAccent],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withValues(alpha: 0.4),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Gradient Button",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _header(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }
}
