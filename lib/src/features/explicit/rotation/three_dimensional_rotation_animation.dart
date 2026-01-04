import 'dart:math' show pi;

import 'package:flutter/material.dart';

import 'package:vector_math/vector_math_64.dart' show Vector3;

class ThreeDimensionalAnimationWidget extends StatefulWidget {
  const ThreeDimensionalAnimationWidget({super.key});

  @override
  State<ThreeDimensionalAnimationWidget> createState() =>
      _ThreeDimensionalAnimationWidgetState();
}

class _ThreeDimensionalAnimationWidgetState
    extends State<ThreeDimensionalAnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;

  late Tween<double> animation;

  @override
  void initState() {
    super.initState();

    _xController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );
    _yController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );
    _zController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    animation = Tween<double>(begin: 0, end: 2 * pi);

    _xController.repeat();
    _yController.repeat();
    _zController.repeat();
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Three Dimensional rotation')),
      body: Padding(
        padding: const EdgeInsets.all(200.0),
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _xController,
            _yController,
            _zController,
          ]),
          builder: (context, child) => Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..rotateX(animation.evaluate(_xController))
              ..rotateY(animation.evaluate(_yController))
              ..rotateZ(animation.evaluate(_zController)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    // back
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..translateByVector3(Vector3(0, 0, -100)),
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.purple,
                      ),
                    ),

                    // left
                    Transform(
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.identity()..rotateY(pi / 2),
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.green,
                      ),
                    ),
                    // right
                    Transform(
                      alignment: Alignment.centerRight,
                      transform: Matrix4.identity()..rotateY(-pi / 2),
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.yellow,
                      ),
                    ),
                    Container(height: 100, width: 100, color: Colors.red),
                    // // top
                    Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()..rotateX(-pi / 2),
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.orange,
                      ),
                    ),
                    Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()..rotateX(pi / 2),
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.brown,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
