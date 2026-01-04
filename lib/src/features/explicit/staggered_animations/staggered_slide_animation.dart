import 'package:flutter/material.dart';

class StaggeredSlideAnimation extends StatefulWidget {
  const StaggeredSlideAnimation({super.key});

  @override
  State<StaggeredSlideAnimation> createState() =>
      _StaggeredSlideAnimationState();
}

class _StaggeredSlideAnimationState extends State<StaggeredSlideAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _animation;
  final count = 10;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = List.generate(
      count,
      (index) => Tween<Offset>(begin: Offset.zero, end: Offset(0.8, 0)).animate(
        CurvedAnimation(
          parent: _controller,
          // Initially we will have 0 * (1 / 10) = 0
          // Then we will have 1 * (1 / 10) = 0.1
          // Then we will have 2 * (1 / 10) = 0.2
          // Then we will have 3 * (1 / 10) = 0.3
          // Then we will have 4 * (1 / 10) = 0.4
          // Then we will have 5 * (1 / 10) = 0.5
          // Then we will have 6 * (1 / 10) = 0.6
          // Then we will have 7 * (1 / 10) = 0.7
          // Then we will have 8 * (1 / 10) = 0.8
          // Then we will have 9 * (1 / 10) = 0.9
          // Finally we will have 10 * (1 / 10) = 1
          curve: Interval(index * (1 / count), 1),
          reverseCurve: Curves.easeInOut,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Staggered Slide Animation')),
      floatingActionButton: Row(
        spacing: 100,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              _controller.reset();
              _controller.forward();
            },
            child: const Icon(Icons.play_arrow),
          ),
          FloatingActionButton(
            heroTag: 'reverse',
            onPressed: () {
              _controller.reverse();
            },
            child: const Icon(Icons.replay),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: count,
        itemBuilder: (context, index) {
          return SlideTransition(
            position: _animation[index],
            child: Text('Item $index'),
          );
        },
      ),
    );
  }
}
