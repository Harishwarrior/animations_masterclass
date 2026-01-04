import 'dart:math' as math;
import 'package:flutter/material.dart';

class SweepGradientExample extends StatefulWidget {
  const SweepGradientExample({super.key});

  @override
  State<SweepGradientExample> createState() => _SweepGradientExampleState();
}

class _SweepGradientExampleState extends State<SweepGradientExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(
      begin: 0,
      end: math.pi * 3 / 2, // 270°
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sweep Gradient Example')),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (_, _) {
            return CustomPaint(
              size: const Size(200, 200),
              painter: SpeedPainter(_animation.value),
            );
          },
        ),
      ),
    );
  }
}

class SpeedPainter extends CustomPainter {
  final double value;

  SpeedPainter(this.value);

  static const startAngle = -math.pi * 3 / 4; // -135°
  static const sweepAngle = math.pi * 3 / 2; // 270°

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = size.center(Offset.zero);

    /// Background arc
    final bgPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, sweepAngle, false, bgPaint);

    /// Gradient progress arc
    final gradientPaint = Paint()
      ..shader = SweepGradient(
        startAngle: startAngle,
        endAngle: startAngle + sweepAngle,
        colors: const [Colors.green, Colors.yellow, Colors.red],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, value, false, gradientPaint);

    /// Center text
    final percentage = (value / sweepAngle * 100).clamp(0, 100).toInt();

    final textPainter = TextPainter(
      text: TextSpan(
        text: '$percentage%',
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      center - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant SpeedPainter oldDelegate) =>
      oldDelegate.value != value;
}
