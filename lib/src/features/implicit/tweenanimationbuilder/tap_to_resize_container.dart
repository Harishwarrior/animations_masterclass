import 'package:flutter/material.dart';

/// A small interactive demo that shows how to use `TweenAnimationBuilder`.
///
/// Tap the square to toggle between small and large sizes. The size,
/// color and border radius interpolate smoothly using a single
/// `TweenAnimationBuilder<double>`.
class TapToResizeContainer extends StatefulWidget {
  const TapToResizeContainer({super.key});

  @override
  State<TapToResizeContainer> createState() => _TapToResizeContainerState();
}

class _TapToResizeContainerState extends State<TapToResizeContainer> {
  bool _large = false;

  static const double _smallSize = 100.0;
  static const double _largeSize = 220.0;
  static const Duration _duration = Duration(milliseconds: 600);
  static const Curve _curve = Curves.easeInOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TweenAnimationBuilder Sample')),
      body: Center(
        child: GestureDetector(
          onTap: () => setState(() => _large = !_large),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(
              begin: _smallSize,
              end: _large ? _largeSize : _smallSize,
            ),
            duration: _duration,
            curve: _curve,
            // Reuse a constant child to avoid rebuilding the icon.
            child: const Icon(Icons.touch_app, color: Colors.white, size: 32),
            builder: (context, size, child) {
              // Normalized t in [0,1] from small -> large
              final t = (size - _smallSize) / (_largeSize - _smallSize);

              // Interpolate color and corner radius based on t
              final color = Color.lerp(Colors.indigo, Colors.orange, t)!;
              final radius = 12.0 + (40.0 - 12.0) * t;

              return Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2 * (0.5 + t / 2)),
                      blurRadius: 12.0 * (0.7 + t),
                      offset: Offset(0, 6 * t),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: child,
              );
            },
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
