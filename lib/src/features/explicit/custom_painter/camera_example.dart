import 'dart:math' as math; // Required for pi and arcs
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: CameraPage()));
}

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text('Painter Tutorial')),
      body: Center(
        // We give the CustomPaint a specific size (300x300)
        child: CustomPaint(
          size: const Size(300, 300),
          painter: CameraPainter(),
        ),
      ),
    );
  }
}

class CameraPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 1. Setup our "Brush"
    final paint = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;

    // --- A. R. Rect (The Body) ---
    // Make a rounded rectangle for the camera body
    // We leave 20px padding on sides and center it vertically
    final bodyRect = Rect.fromLTWH(20, 80, size.width - 40, 140);
    final roundedBody = RRect.fromRectAndRadius(
      bodyRect,
      const Radius.circular(20),
    );
    canvas.drawRRect(roundedBody, paint);

    // --- B. Circle (The Lens) ---
    paint.color = Colors.white; // Change brush color
    final centerPoint = Offset(size.width / 2, size.height / 2);
    // Draw a circle at the exact center, radius 50
    canvas.drawCircle(centerPoint, 50, paint);

    // --- C. Rect (The Flash) ---
    paint.color = Colors.yellow[700]!;
    // Define a rectangle at top-right of the camera body
    final flashRect = Rect.fromLTWH(size.width - 80, 90, 40, 30);
    canvas.drawRect(flashRect, paint);

    // --- D. Line (Flash Detail) ---
    paint.color = Colors.black;
    paint.strokeWidth = 3;
    // Draw a line across the flash
    final p1 = Offset(size.width - 80, 105); // Left side of flash
    final p2 = Offset(size.width - 40, 105); // Right side of flash
    canvas.drawLine(p1, p2, paint);

    // --- E. Oval (Shutter Button) ---
    paint.color = Colors.red;
    // An oval fits inside a rect. We define a flat rect on top of the camera.
    final buttonRect = Rect.fromLTWH(60, 65, 50, 30);
    canvas.drawOval(buttonRect, paint);

    // --- F. Arc (Lens Glare) ---
    paint.color = Colors.grey[300]!;
    paint.style = PaintingStyle.stroke; // Outline only
    paint.strokeWidth = 5;

    // Arcs also need a Rect to live inside (we use the lens size)
    final lensRect = Rect.fromCircle(center: centerPoint, radius: 40);

    // Draw arc:
    // Start angle: -pi/4 (Top Right diagonal)
    // Sweep angle: pi/2 (Quarter circle length)
    // useCenter: false (Don't connect to middle like a pie slice)
    canvas.drawArc(lensRect, -math.pi / 4, math.pi / 2, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
