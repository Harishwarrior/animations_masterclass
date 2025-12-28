import 'package:flutter/material.dart';

class LogoFadeAnimation extends StatefulWidget {
  const LogoFadeAnimation({super.key});

  @override
  State<LogoFadeAnimation> createState() => _LogoFadeAnimationState();
}

class _LogoFadeAnimationState extends State<LogoFadeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

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
      appBar: AppBar(title: const Text('Logo Fade Animation')),
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: IconButton(
            onPressed: () {
              if (_controller.isCompleted) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
            },
            icon: Icon(Icons.flutter_dash, size: 100),
          ),
        ),
      ),
    );
  }
}
