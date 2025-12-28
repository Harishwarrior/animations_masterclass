import 'package:flutter/material.dart';

/// A small interactive demo using `AnimatedContainer`.
///
/// Tap the square to toggle between small and large sizes. The size,
/// color, border radius, and shadow animate automatically.
///
/// Compare this with the `TweenAnimationBuilder` version to see the differences.
class TapToResizeContainerAnimated extends StatefulWidget {
  const TapToResizeContainerAnimated({super.key});

  @override
  State<TapToResizeContainerAnimated> createState() =>
      _TapToResizeContainerAnimatedState();
}

class _TapToResizeContainerAnimatedState
    extends State<TapToResizeContainerAnimated> {
  bool _large = false;

  static const double _smallSize = 100.0;
  static const double _largeSize = 220.0;
  static const Duration _duration = Duration(milliseconds: 600);
  static const Curve _curve = Curves.easeInOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedContainer Sample')),
      body: Center(
        child: GestureDetector(
          onTap: () => setState(() => _large = !_large),
          // AnimatedContainer automatically animates between old and new values
          // when any of its properties change.
          child: AnimatedContainer(
            duration: _duration,
            curve: _curve,
            width: _large ? _largeSize : _smallSize,
            height: _large ? _largeSize : _smallSize,
            decoration: BoxDecoration(
              color: _large ? Colors.orange : Colors.indigo,
              borderRadius: BorderRadius.circular(_large ? 40 : 12),
              boxShadow: [
                BoxShadow(
                  // Shadow animates between these two discrete states
                  // (no intermediate values like with TweenAnimationBuilder)
                  color: Colors.black.withOpacity(_large ? 0.3 : 0.1),
                  blurRadius: _large ? 20.0 : 8.0,
                  offset: Offset(0, _large ? 6 : 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.touch_app, color: Colors.white, size: 32),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => setState(() => _large = !_large),
        label: Text(_large ? 'Shrink' : 'Grow'),
        icon: Icon(_large ? Icons.remove : Icons.add),
      ),
    );
  }
}
