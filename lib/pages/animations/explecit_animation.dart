import 'package:flutter/material.dart';

class ExplicitAnimation1 extends StatefulWidget {
  const ExplicitAnimation1({super.key});

  @override
  State<ExplicitAnimation1> createState() => _ExplicitAnimation1State();
}

class _ExplicitAnimation1State extends State<ExplicitAnimation1>
    with SingleTickerProviderStateMixin {
  late Animation<double> sizeAnimation;
  late Animation<double> floatAnimation;
  late AnimationController controller;

  bool isGrowing = true;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    sizeAnimation =
        Tween<double>(begin: 0, end: 150).animate(
          CurvedAnimation(parent: controller, curve: Curves.easeOut),
        )..addListener(() {
          setState(() {});
        });

    floatAnimation = Tween<double>(
      begin: 0,
      end: -20,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && isGrowing) {
        setState(() => isGrowing = false);
        controller.duration = const Duration(seconds: 1);
        controller.repeat(reverse: true);
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform.translate(
          offset: Offset(0, isGrowing ? 0 : floatAnimation.value),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: isGrowing ? sizeAnimation.value : 150,
            width: isGrowing ? sizeAnimation.value : 150,
            child: const FlutterLogo(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
