import 'package:flutter/material.dart';

class ThemeAndColor extends StatefulWidget {
  const ThemeAndColor({super.key});

  @override
  State<ThemeAndColor> createState() => _ThemeAndColorState();
}

class _ThemeAndColorState extends State<ThemeAndColor> {
  bool isDarkMode = false;
  // boolean to track the current state
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    // 1. Defining Custom Themes locally to demonstrate understanding
    // Professional Light Theme
    final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.lightBlueAccent,
      scaffoldBackgroundColor: Colors.grey[100],
      cardColor: Colors.white,
      colorScheme: ColorScheme.light(
        primary: Colors.lightBlueAccent,
        secondary: Colors.amber, // Accent color
      ),
      textTheme: TextTheme(
        headlineMedium: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(color: Colors.grey[800]),
      ),
    );

    // Cyberpunk Dark Theme
    final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.blueGrey,
      scaffoldBackgroundColor: Color(0xFF121212), // Using Hex Code
      cardColor: Color(0xFF3C3C3C),
      colorScheme: ColorScheme.dark(
        primary: Colors.blueGrey,
        secondary: Colors.pinkAccent,
      ),
      textTheme: TextTheme(
        headlineMedium: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(color: Colors.grey[300]),
      ),
    );

    // Get current active theme data based on boolean
    ThemeData activeTheme = _isDarkMode ? darkTheme : lightTheme;

    // We wrap the page in a Theme widget to override the app's global theme just for this screen
    return Theme(
      data: activeTheme,
      child: Scaffold(
        backgroundColor: activeTheme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: activeTheme.primaryColor,
          title: Text("Theme & Color Change"),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. DYNAMIC TEXT COLOR
                Text(
                  _isDarkMode ? "Dark Mode Active" : "Light Mode Active",
                  style: activeTheme.textTheme.headlineMedium,
                ),
                SizedBox(height: 10),
                Text(
                  "The cards and text adapt automatically.",
                  style: activeTheme.textTheme.bodyMedium,
                ),
                SizedBox(height: 30),

                // 2. ADAPTIVE CARDS (Uses Theme.of(context))
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: activeTheme.cardColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: _isDarkMode ? Colors.black45 : Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.palette,
                        size: 40,
                        color: activeTheme.colorScheme.secondary,
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Contact Card",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "This is the contact card for the user",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                // 3. HEX COLORS & OPACITY
                Container(
                  height: 80,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    // Demonstrating manual HEX color usage (0xFF + HexCode)
                    color: Color(0xFFFF5733).withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Same Color Button",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // 4. GRADIENT BUTTON
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      colors: _isDarkMode
                          ? [
                              Colors.teal,
                              Colors.blue,
                            ] // Cool tones for dark mode
                          : [
                              Colors.orange,
                              Colors.red,
                            ], // Warm tones for light mode
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Gradient Button",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Floating Action Button that changes color based on theme accent
        floatingActionButton: FloatingActionButton(
          backgroundColor: activeTheme.colorScheme.secondary,
          shape: CircleBorder(),
          onPressed: () {},
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
