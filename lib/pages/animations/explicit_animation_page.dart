import 'package:flutter/material.dart';
import 'dart:math'; // Needed for the spinner calculation

class ExplicitAnimationPage extends StatefulWidget {
  @override
  _ExplicitAnimationPageState createState() => _ExplicitAnimationPageState();
}

// 1. THE MIXIN
// Essential: SingleTickerProviderStateMixin gives the controller access to the device's clock (vsync)
class _ExplicitAnimationPageState extends State<ExplicitAnimationPage>
    with SingleTickerProviderStateMixin {
  // 2. THE CONTROLLER
  // The "Engine" that drives the animation from 0.0 to 1.0
  late AnimationController _controller;

  // 3. THE ANIMATIONS (The individual moving parts)
  late Animation<double> _squeezeAnimation;
  late Animation<double> _scaleCheckAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize Controller (Total duration: 2 seconds)
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    // 4. STAGGERED ANIMATIONS (Intervals)
    // The controller goes from 0.0 to 1.0. We split that time up.

    // PHASE 1: Squeeze Button (0% to 30% of time)
    _squeezeAnimation = Tween<double>(begin: 250.0, end: 60.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.30, curve: Curves.easeInOut),
      ),
    );

    // PHASE 2: Color Change (30% to 60%)
    _colorAnimation = ColorTween(begin: Colors.blue[900], end: Colors.green)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(0.30, 0.60, curve: Curves.ease),
          ),
        );

    // PHASE 3: Checkmark Pop (60% to 100%)
    // ElasticOut creates that "Boing" bounce effect
    _scaleCheckAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.60, 1.0, curve: Curves.elasticOut),
      ),
    );

    // Optional: Reset when finished for demo purposes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Maybe navigate to next screen?
      }
    });
  }

  @override
  void dispose() {
    _controller
        .dispose(); // CRITICAL: Always dispose controllers to stop memory leaks
    super.dispose();
  }

  void _startAnimation() {
    if (_controller.isCompleted) {
      _controller.reverse(); // Go back to start
    } else {
      _controller.forward(); // Play animation
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Explicit Animations")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tap to Pay",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 30),

            // 5. ANIMATED BUILDER
            // Using AnimatedBuilder is better than setState because it only rebuilds THIS
            // 5. ANIMATED BUILDER
            // Using AnimatedBuilder is better than setState because it only rebuilds
            // the specific widget being animated, not the whole screen.
            GestureDetector(
              onTap: () {
                if (_controller.isCompleted) {
                  _controller.reverse(); // Reset
                } else {
                  _controller.forward(); // Play
                }
              },
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Container(
                    // 6. APPLYING THE TWEENS
                    // The width follows the squeeze animation (250 -> 60)
                    width: _squeezeAnimation.value,
                    height: 60.0,
                    decoration: BoxDecoration(
                      // The color follows the color tween (Blue -> Green)
                      color: _colorAnimation.value,
                      borderRadius: BorderRadius.circular(
                        30.0,
                      ), // Keeps it rounded
                      boxShadow: [
                        BoxShadow(
                          color: _colorAnimation.value!.withOpacity(0.4),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      // 7. CONDITIONAL CONTENT
                      // If width is wide (> 75), show Text. If narrow, show Checkmark.
                      child: _squeezeAnimation.value > 75.0
                          ? Text(
                              "PAY NOW",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 1.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow
                                  .fade, // Fades out text as it shrinks
                            )
                          : Transform.scale(
                              // 8. ELASTIC CHECKMARK
                              // This scales from 0.0 to 1.0 with an elastic bounce
                              scale: _scaleCheckAnimation.value,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 50),

            // Visual Progress Indicator (Optional Debugging Tool)
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Column(
                  children: [
                    Text(
                      "Animation Progress: ${(_controller.value * 100).toInt()}%",
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(value: _controller.value),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
