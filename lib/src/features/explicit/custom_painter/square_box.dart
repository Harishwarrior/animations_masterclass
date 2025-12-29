import 'package:flutter/material.dart';

class SquareBox extends StatefulWidget {
  const SquareBox({super.key});

  @override
  State<SquareBox> createState() => _SquareBoxState();
}

class _SquareBoxState extends State<SquareBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Square Box')),
      body: CustomPaint(painter: SquareBoxPainter()),
    );
  }
}

class SquareBoxPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.pink
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.square;
    canvas.drawLine(Offset(20, 20), Offset(100, 20), paint);
    canvas.drawLine(Offset(100, 20), Offset(100, 100), paint);
    canvas.drawLine(Offset(100, 100), Offset(20, 100), paint);
    canvas.drawLine(Offset(20, 100), Offset(20, 20), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
