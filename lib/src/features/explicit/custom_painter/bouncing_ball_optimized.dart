import 'package:flutter/material.dart';

class BouncingBallOptimized extends StatefulWidget {
  const BouncingBallOptimized({super.key});

  @override
  State<BouncingBallOptimized> createState() => _BouncingBallOptimizedState();
}

class _BouncingBallOptimizedState extends State<BouncingBallOptimized>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 200, end: 300).animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bouncing Ball Animation')),
      body: RepaintBoundary(
        child: CustomPaint(painter: BouncingBallPainter(_animation)),
      ),
    );
  }
}

class BouncingBallPainter extends CustomPainter {
  final Animation<double> _animation;
  BouncingBallPainter(this._animation) : super(repaint: _animation);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.red;
    canvas.drawCircle(Offset(100, _animation.value), 40, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
