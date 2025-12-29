import 'dart:math';

import 'package:flutter/material.dart';

class TwoHalfCircle extends StatefulWidget {
  const TwoHalfCircle({super.key});

  @override
  State<TwoHalfCircle> createState() => _TwoHalfCircleState();
}

class _TwoHalfCircleState extends State<TwoHalfCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(
      begin: 0,
      end: -(pi / 2),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));

    _controller.forward();

    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reverse();
      } else if (_controller.isDismissed) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Two Half Circle')),
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateZ(_animation.value),
                child: CustomPaint(
                  size: Size(100, 100),
                  painter: TwoHalfCirclePainter(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class TwoHalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Left Half (Blue)
    final leftHalfPaint = Paint()..color = Colors.blue;
    canvas.drawArc(
      rect,
      pi / 2, // Starts at 90 deg (bottom)
      pi, // Sweeps 180 deg clockwise to top (covering left)
      true,
      leftHalfPaint,
    );

    // Right Half (Red)
    final rightHalfPaint = Paint()..color = Colors.red;
    canvas.drawArc(
      rect,
      -pi / 2, // Starts at -90 deg (top)
      pi, // Sweeps 180 deg clockwise to bottom (covering right)
      true,
      rightHalfPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
