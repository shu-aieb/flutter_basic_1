import 'package:flutter/material.dart';

class ImplicitAnimationsPage extends StatefulWidget {
  const ImplicitAnimationsPage({super.key});

  @override
  _ImplicitAnimationsPageState createState() => _ImplicitAnimationsPageState();
}

class _ImplicitAnimationsPageState extends State<ImplicitAnimationsPage> {
  bool _isDownloading = false;
  bool _isCompleted = false;
  bool _isExpanded = false;

  void _startDownload() async {
    setState(() {
      _isDownloading = true;
      _isExpanded = true;
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isDownloading = false;
      _isCompleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text("Implicit Animations")),
      body: Center(
        child: GestureDetector(
          onTap: () {
            if (!_isDownloading) {
              // && !_isCompleted
              setState(() => _isExpanded = !_isExpanded);
            }
          },
          // 3. ANIMATED CONTAINER (The Card)
          // Animates: Height, Color, Border Radius, Shadow
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutExpo,
            width: 320,
            height: _isExpanded ? 400 : 200,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _isCompleted ? Colors.green[50] : Colors.white,
              borderRadius: BorderRadius.circular(_isExpanded ? 30 : 15),
              boxShadow: [
                BoxShadow(
                  color: _isCompleted
                      ? Colors.green.withOpacity(0.2)
                      : Colors.black12,
                  blurRadius: _isExpanded ? 20 : 10,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // 4. ANIMATED CONTAINER (The Icon Box)
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: _isCompleted ? Colors.green : Colors.blueAccent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(Icons.gamepad, color: Colors.white, size: 30),
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cyber Racer 2077",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // 5. ANIMATED OPACITY
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 300),
                          opacity: _isExpanded
                              ? 1.0
                              : 0.0, // Hide subtitle when collapsed
                          child: Text(
                            "Racing / RPG",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 15),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: (!_isDownloading && _isCompleted && _isExpanded)
                          ? 1.0
                          : 0.0,
                      child: AnimatedContainer(
                        alignment: Alignment.center,
                        duration: Duration(milliseconds: 500),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.redAccent.shade400,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _isExpanded = false;
                              _isCompleted = false;
                              _isDownloading = false;
                            });
                          },
                          icon: Icon(Icons.undo, color: Colors.white, size: 24),
                        ),
                      ),
                    ),
                  ],
                ),

                // Content that appears when expanded
                // We use Flexible/Overflow handling for safety
                Expanded(
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: _isExpanded ? 1.0 : 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        "Experience the ultimate futuristic racing game. Customize your vehicle, challenge players worldwide, and dominate the leaderboards.",
                        style: TextStyle(color: Colors.grey[600], height: 1.5),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),

                // THE DOWNLOAD BUTTON
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: _isCompleted ? () {} : _startDownload,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOutBack,
                      width: _isDownloading ? 50 : (_isCompleted ? 300 : 120),
                      height: 50,
                      decoration: BoxDecoration(
                        color: _isDownloading
                            ? Colors.grey[200]
                            : (_isCompleted ? Colors.green : Colors.blueAccent),
                        borderRadius: BorderRadius.circular(
                          _isDownloading ? 50 : 25,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: _isDownloading
                          ? SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.blueAccent,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // 7. ANIMATED SWITCHER (Icon Swap)
                                AnimatedSwitcher(
                                  duration: Duration(milliseconds: 300),
                                  transitionBuilder: (child, anim) =>
                                      ScaleTransition(
                                        scale: anim,
                                        child: child,
                                      ),
                                  child: Icon(
                                    _isCompleted
                                        ? Icons.play_arrow
                                        : Icons.download,
                                    key: ValueKey(_isCompleted),
                                    color: Colors.white,
                                  ),
                                ),
                                // Text Logic
                                if (!_isDownloading) ...[
                                  SizedBox(width: 8),
                                  // 8. ANIMATED TEXT STYLE
                                  AnimatedDefaultTextStyle(
                                    duration: Duration(milliseconds: 300),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      _isCompleted ? "OPEN GAME" : "GET",
                                    ),
                                  ),
                                ],
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
