import 'dart:math';
import 'package:flutter/material.dart';

class SpendingCategory {
  final String name;
  final double amount;
  final Color color;
  final IconData icon;

  SpendingCategory(this.name, this.amount, this.color, this.icon);
}

class CustomPainterPage extends StatefulWidget {
  @override
  _CustomPainterPageState createState() => _CustomPainterPageState();
}

class _CustomPainterPageState extends State<CustomPainterPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // Mock Data
  final List<SpendingCategory> data = [
    SpendingCategory("Rent", 500, Colors.blueAccent, Icons.home),
    SpendingCategory("Food", 300, Colors.orangeAccent, Icons.fastfood),
    SpendingCategory("Fun", 150, Colors.purpleAccent, Icons.movie),
    SpendingCategory("Savings", 250, Colors.greenAccent, Icons.savings),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCirc,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _replayAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double totalSpent = data.fold(0, (sum, item) => sum + item.amount);

    return Scaffold(
      backgroundColor: Color(0xFF1E1E2C),
      appBar: AppBar(
        title: Text(
          "Custom Paint Animation",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: _replayAnimation,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 40),

          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Total Spent",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Text(
                        "\$${(totalSpent * _animation.value).toInt()}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  CustomPaint(
                    size: Size(250, 250),
                    painter: RingChartPainter(
                      categories: data,
                      animationValue: _animation.value,
                    ),
                  ),
                ],
              );
            },
          ),

          SizedBox(height: 50),

          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return Transform.translate(
                  offset: Offset(0, 50 * (1 - _animation.value)),
                  child: Opacity(
                    opacity: _animation.value,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: item.color.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(item.icon, color: item.color, size: 20),
                          ),
                          SizedBox(width: 15),
                          Text(
                            item.name,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Spacer(),
                          Text(
                            "\$${item.amount.toInt()}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RingChartPainter extends CustomPainter {
  final List<SpendingCategory> categories;
  final double animationValue;

  RingChartPainter({required this.categories, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    double strokeWidth = 20.0;

    double total = categories.fold(0, (sum, item) => sum + item.amount);

    double startAngle = -pi / 2;

    Paint backgroundPaint = Paint()
      ..color = Colors.white10
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    for (var item in categories) {
      double sweepAngle = (item.amount / total) * 2 * pi;

      double animatedSweep = sweepAngle * animationValue;

      Paint arcPaint = Paint()
        ..color = item.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        animatedSweep,
        false, // useCenter: false means it's a ring, not a pie slice
        arcPaint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant RingChartPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
