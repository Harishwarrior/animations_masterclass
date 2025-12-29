import 'package:flutter/material.dart';

class SweepGradientExample extends StatefulWidget {
  const SweepGradientExample({super.key});

  @override
  State<SweepGradientExample> createState() => _SweepGradientExampleState();
}

class _SweepGradientExampleState extends State<SweepGradientExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sweep Gradient Example')),
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: CustomPaint(painter: SpeedPainter(3.14)),
        ),
      ),
    );
  }
}

class SpeedPainter extends CustomPainter {
  final double value;

  SpeedPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final paint = Paint()
      ..shader = SweepGradient(
        colors: [Colors.green, Colors.red],
        startAngle: -3.14 * 3 / 4,
        endAngle: 3.14 * 3 / 4,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;

    canvas.drawArc(rect, -3.14 * 3 / 4, value, false, paint);
  }

  @override
  bool shouldRepaint(covariant SpeedPainter old) => old.value != value;
}
