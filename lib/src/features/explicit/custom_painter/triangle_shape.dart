import 'package:flutter/material.dart';

class TriangleShape extends StatelessWidget {
  const TriangleShape({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Triangle Shape')),
      body: CustomPaint(size: Size(200, 200), painter: TriangleShapePainter()),
    );
  }
}

class TriangleShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke; // Change to .fill to fill the shape

    final path = Path();

    // 1. Move to the top center point
    path.moveTo(size.width / 2, 0);

    // 2. Draw line to bottom right
    path.lineTo(size.width, size.height);

    // 3. Draw line to bottom left
    path.lineTo(0, size.height);

    // 4. Close the path (connects back to step 1)
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
