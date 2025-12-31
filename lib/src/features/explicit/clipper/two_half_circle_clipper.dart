import 'dart:math';

import 'package:flutter/material.dart';

class TwoHalfCircleClipperWidget extends StatefulWidget {
  const TwoHalfCircleClipperWidget({super.key});

  @override
  State<TwoHalfCircleClipperWidget> createState() =>
      _TwoHalfCircleClipperWidgetState();
}

class _TwoHalfCircleClipperWidgetState extends State<TwoHalfCircleClipperWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _flipAnimationController;
  late Animation _rotateAnimation;
  late Animation _flipAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _flipAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _rotateAnimation = Tween<double>(begin: 0, end: -(pi / 2)).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.bounceOut),
    );

    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(
        parent: _flipAnimationController,
        curve: Curves.bounceOut,
      ),
    );

    _animationController.forward();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipAnimation =
            Tween<double>(
              begin: _flipAnimation.value,
              end: _flipAnimation.value + pi,
            ).animate(
              CurvedAnimation(
                parent: _flipAnimationController,
                curve: Curves.bounceOut,
              ),
            );
        _flipAnimationController.reset();
        _flipAnimationController.forward();
      }
    });

    _flipAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _rotateAnimation =
            Tween<double>(
              begin: _rotateAnimation.value,
              end: _rotateAnimation.value + -(pi / 2),
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.bounceOut,
              ),
            );
        _animationController.reset();
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _flipAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TwoHalfCircleClipper Demo')),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..rotateZ(_rotateAnimation.value),
          child: AnimatedBuilder(
            animation: _flipAnimationController,
            builder: (context, child) => Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateY(_flipAnimation.value),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipPath(
                    clipper: HalfCircleClipper(side: CircleSide.left),
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.amber,
                    ),
                  ),
                  ClipPath(
                    clipper: HalfCircleClipper(side: CircleSide.right),
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum CircleSide { left, right }

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide side;

  HalfCircleClipper({super.reclip, required this.side});
  @override
  Path getClip(Size size) {
    final path = Path();
    final Offset offset;
    final bool clockwise;

    switch (side) {
      case .left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;

      case .right:
        offset = Offset(0, size.height);
        clockwise = true;
    }
    path.arcToPoint(
      offset,
      radius: Radius.elliptical(size.width / 2, size.height / 2),
      clockwise: clockwise,
    );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) {
    return true;
  }
}
