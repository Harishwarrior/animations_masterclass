import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A showcase of TweenAnimationBuilder's unique capabilities.
///
/// This example demonstrates things that AnimatedContainer CANNOT do:
/// 1. Animating non-visual values (numbers, text)
/// 2. Animating rotations and transforms based on progress
/// 3. Syncing multiple derived animations from a single tween
class TweenAnimationShowcase extends StatefulWidget {
  const TweenAnimationShowcase({super.key});

  @override
  State<TweenAnimationShowcase> createState() => _TweenAnimationShowcaseState();
}

class _TweenAnimationShowcaseState extends State<TweenAnimationShowcase> {
  double _targetValue = 0;

  void _randomize() {
    setState(() {
      _targetValue = math.Random().nextDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TweenAnimationBuilder Power'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // ══════════════════════════════════════════════════════════
            // EXAMPLE 1: Animated Counter (Impossible with AnimatedContainer)
            // ══════════════════════════════════════════════════════════
            _buildSection(
              title: '1. Animated Counter',
              subtitle: 'AnimatedContainer cannot animate text values!',
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: _targetValue * 100),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Text(
                    value.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      color: Color.lerp(Colors.blue, Colors.red, value / 100),
                    ),
                  );
                },
              ),
            ),

            // ══════════════════════════════════════════════════════════
            // EXAMPLE 2: Circular Progress with Synced Animations
            // ══════════════════════════════════════════════════════════
            _buildSection(
              title: '2. Synced Progress Ring',
              subtitle: 'One tween drives: arc, color, glow, and text',
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: _targetValue),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
                builder: (context, progress, child) {
                  final color = Color.lerp(Colors.red, Colors.green, progress)!;

                  return SizedBox(
                    width: 120,
                    height: 120,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Glowing background (intensity based on progress)
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: color.withOpacity(0.3 * progress),
                                blurRadius: 20 * progress,
                                spreadRadius: 5 * progress,
                              ),
                            ],
                          ),
                        ),
                        // Progress arc
                        CustomPaint(
                          size: const Size(100, 100),
                          painter: _ProgressPainter(
                            progress: progress,
                            color: color,
                          ),
                        ),
                        // Percentage text
                        Text(
                          '${(progress * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // ══════════════════════════════════════════════════════════
            // EXAMPLE 3: 3D Rotation Effect
            // ══════════════════════════════════════════════════════════
            _buildSection(
              title: '3. 3D Flip Transform',
              subtitle: 'Rotation + perspective from one tween',
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: _targetValue),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                builder: (context, t, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      // ..setEntry(3, 2, 0.001) // perspective
                      ..rotateY(t * math.pi), // rotate based on t
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        // Show different face based on rotation angle
                        color: t < 0.5 ? Colors.deepPurple : Colors.teal,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 12,
                            // offset: Offset(10 * (0.5 - t).abs(), 8),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        t < 0.5 ? Icons.favorite : Icons.star,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _randomize,
        label: const Text('Randomize'),
        icon: const Icon(Icons.shuffle),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}

/// Custom painter for drawing the progress arc
class _ProgressPainter extends CustomPainter {
  final double progress;
  final Color color;

  _ProgressPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // Prepare where it should be in canvas
    final center = Offset(size.width / 2, size.height / 2);
    // Prepare radius
    // Radius is half of the width
    // - 8 is for padding
    final radius = size.width / 2;

    // Background circle
    final bgPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    canvas.drawCircle(center, radius, bgPaint);

    // Draw line
    final linePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10;

    canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), linePaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from top
      2 * math.pi * progress, // Sweep based on progress
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_ProgressPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
