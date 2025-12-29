import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AnalogClock extends StatefulWidget {
  const AnalogClock({super.key});

  @override
  State<AnalogClock> createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Update the clock every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analog Clock')),
      body: SafeArea(
        child: Center(
          child: CustomPaint(
            size: const Size(300, 300),
            painter: ClockPainter(time: _currentTime),
          ),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  final DateTime time;

  ClockPainter({required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    // Draw clock face
    final facePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, facePaint);

    // Draw clock border
    final borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(center, radius, borderPaint);

    // Draw hour markers
    final hourMarkerPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 12; i++) {
      final angle = (i * 30) * pi / 180;
      final x1 = center.dx + (radius - 20) * cos(angle - pi / 2);
      final y1 = center.dy + (radius - 20) * sin(angle - pi / 2);
      final x2 = center.dx + (radius - 10) * cos(angle - pi / 2);
      final y2 = center.dy + (radius - 10) * sin(angle - pi / 2);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), hourMarkerPaint);
    }

    // Calculate angles for hands
    final secondAngle = (time.second * 6) * pi / 180;
    final minuteAngle = ((time.minute + time.second / 60) * 6) * pi / 180;
    final hourAngle = ((time.hour % 12 + time.minute / 60) * 30) * pi / 180;

    // Draw hour hand
    final hourHandPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    final hourHandLength = radius * 0.5;
    canvas.drawLine(
      center,
      Offset(
        center.dx + hourHandLength * cos(hourAngle - pi / 2),
        center.dy + hourHandLength * sin(hourAngle - pi / 2),
      ),
      hourHandPaint,
    );

    // Draw minute hand
    final minuteHandPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    final minuteHandLength = radius * 0.7;
    canvas.drawLine(
      center,
      Offset(
        center.dx + minuteHandLength * cos(minuteAngle - pi / 2),
        center.dy + minuteHandLength * sin(minuteAngle - pi / 2),
      ),
      minuteHandPaint,
    );

    // Draw second hand
    final secondHandPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    final secondHandLength = radius * 0.8;
    canvas.drawLine(
      center,
      Offset(
        center.dx + secondHandLength * cos(secondAngle - pi / 2),
        center.dy + secondHandLength * sin(secondAngle - pi / 2),
      ),
      secondHandPaint,
    );

    // Draw center dot
    final centerDotPaint = Paint()..color = Colors.black;
    canvas.drawCircle(center, 8, centerDotPaint);
  }

  @override
  bool shouldRepaint(covariant ClockPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}
