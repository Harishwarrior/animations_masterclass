import 'package:flutter/material.dart';

class BouncingBallAnimation extends StatefulWidget {
  const BouncingBallAnimation({super.key});

  @override
  State<BouncingBallAnimation> createState() => _BouncingBallAnimationState();
}

class _BouncingBallAnimationState extends State<BouncingBallAnimation>
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
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: BouncingBallPainter(dy: _animation.value),
            );
          },
        ),
      ),
    );
  }
}

class BouncingBallPainter extends CustomPainter {
  final double dy;
  BouncingBallPainter({required this.dy});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.red;
    canvas.drawCircle(Offset(100, dy), 40, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
