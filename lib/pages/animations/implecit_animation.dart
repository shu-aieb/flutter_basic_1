import 'package:flutter/material.dart';

class ImplicitAnimation extends StatefulWidget {
  const ImplicitAnimation({super.key});

  @override
  State<ImplicitAnimation> createState() => _ImplicitAnimationState();
}

class _ImplicitAnimationState extends State<ImplicitAnimation> {
  Color color = Colors.amber;
  double width = 100;
  bool isSmall = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  height: 30,
                  width: width,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: isSmall ? null : BorderRadius.circular(20),
                  ),
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeInOut,
                ),
                Row(
                  children: [
                    Divider(),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: isSmall
                            ? Colors.green
                            : Colors.redAccent,
                      ),
                      onPressed: () {
                        setState(() {
                          if (isSmall) {
                            color = Colors.redAccent;
                            width = 200;
                          } else {
                            color = Colors.green;
                            width = 100;
                          }
                          isSmall = !isSmall;
                        });
                      },
                      child: Text(isSmall ? 'Fill' : 'Empty'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
