import 'package:flutter/material.dart';

class ThemeAndColorWithAnimation extends StatefulWidget {
  const ThemeAndColorWithAnimation({super.key});

  @override
  State<ThemeAndColorWithAnimation> createState() =>
      _ThemeAndColorWithAnimationState();
}

class _ThemeAndColorWithAnimationState
    extends State<ThemeAndColorWithAnimation> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    // 1. Define Themes
    final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.deepPurple,
      scaffoldBackgroundColor: Colors.grey[200],
      cardColor: Colors.white,
      colorScheme: ColorScheme.light(
        primary: Colors.deepPurple,
        secondary: Colors.orange,
      ),
    );

    final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Color(0xFF1F1F1F),
      cardColor: Color(0xFF2C2C2C),
      colorScheme: ColorScheme.dark(
        primary: Colors.tealAccent,
        secondary: Colors.teal,
      ),
    );

    // 2. USE ANIMATED THEME instead of Theme
    // This widget automatically animates changes to the theme data over the duration.
    return AnimatedTheme(
      data: _isDarkMode ? darkTheme : lightTheme,
      duration: Duration(milliseconds: 500), // 0.5 seconds smoothness
      curve: Curves.easeInOut, // Natural easing
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _isDarkMode ? Colors.black : Colors.deepPurple,
          title: Text("Animated Theme Switcher"),
          actions: [
            // 3. ANIMATED ICON SWITCHER
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isDarkMode = !_isDarkMode;
                  });
                },
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        // This creates a cool Rotation + Fade effect
                        return RotationTransition(
                          turns: child.key == ValueKey('icon1')
                              ? Tween<double>(
                                  begin: 1,
                                  end: 0.75,
                                ).animate(animation)
                              : Tween<double>(
                                  begin: 0.75,
                                  end: 1,
                                ).animate(animation),
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                  child: _isDarkMode
                      ? Icon(
                          Icons.dark_mode,
                          key: ValueKey('icon1'),
                          color: Colors.tealAccent,
                        )
                      : Icon(
                          Icons.wb_sunny,
                          key: ValueKey('icon2'),
                          color: Colors.orangeAccent,
                        ),
                ),
              ),
            ),
          ],
        ),

        // Using Builder to access the AnimatedTheme data properly
        body: Builder(
          builder: (context) {
            final theme = Theme.of(context);

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 4. ANIMATED CONTAINER
                  // This box changes color and border radius smoothly
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(
                        _isDarkMode ? 50 : 10,
                      ), // Circle in dark, Square in light
                      boxShadow: [
                        BoxShadow(
                          color: _isDarkMode
                              ? Colors.tealAccent.withOpacity(0.3)
                              : Colors.black12,
                          blurRadius: _isDarkMode ? 20 : 10,
                          spreadRadius: _isDarkMode ? 5 : 1,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.touch_app,
                        size: 50,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ),

                  SizedBox(height: 40),

                  // 5. ANIMATED TEXT STYLE
                  AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 500),
                    style: TextStyle(
                      fontSize: _isDarkMode
                          ? 28
                          : 22, // Text gets bigger in dark mode
                      fontWeight: _isDarkMode
                          ? FontWeight.w300
                          : FontWeight.bold,
                      color: theme.textTheme.bodyMedium?.color ?? Colors.black,
                      letterSpacing: _isDarkMode ? 2.0 : 0.0,
                    ),
                    child: Text(_isDarkMode ? "NIGHT MODE" : "DAY MODE"),
                  ),

                  SizedBox(height: 10),
                  Text("Tap the icon in the top right"),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
