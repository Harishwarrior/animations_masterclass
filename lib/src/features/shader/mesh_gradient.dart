import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ShaderExample extends StatefulWidget {
  const ShaderExample({super.key});

  @override
  State<ShaderExample> createState() => _ShaderExampleState();
}

class _ShaderExampleState extends State<ShaderExample>
    with SingleTickerProviderStateMixin {
  FragmentProgram? _program;
  late Ticker _ticker;
  double _time = 0.0;

  @override
  void initState() {
    super.initState();
    _loadShader();
    // Ticker updates the time variable for the animation
    _ticker = createTicker((elapsed) {
      setState(() {
        _time = elapsed.inMilliseconds / 1000.0;
      });
    })..start();
  }

  Future<void> _loadShader() async {
    // Load the compiled shader from assets
    final program = await FragmentProgram.fromAsset(
      'assets/shaders/mesh_gradient.frag',
    );
    setState(() => _program = program);
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_program == null) return const CircularProgressIndicator();

    return Scaffold(
      appBar: AppBar(),
      body: CustomPaint(
        size: Size.infinite,
        painter: MeshGradientPainter(
          shader: _program!.fragmentShader(),
          time: _time,
        ),
      ),
    );
  }
}

class MeshGradientPainter extends CustomPainter {
  final FragmentShader shader;
  final double time;

  MeshGradientPainter({required this.shader, required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Pass Uniforms (Must match the order in the GLSL file)
    shader.setFloat(0, size.width); // uSize.x
    shader.setFloat(1, size.height); // uSize.y
    shader.setFloat(2, time); // uTime

    // 2. Create Paint with the shader
    final paint = Paint()..shader = shader;

    // 3. Draw
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant MeshGradientPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}
