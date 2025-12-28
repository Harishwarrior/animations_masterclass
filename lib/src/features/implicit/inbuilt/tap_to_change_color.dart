import 'package:flutter/material.dart';

class TapToChangeColor extends StatefulWidget {
  const TapToChangeColor({super.key});

  @override
  State<TapToChangeColor> createState() => _TapToScaleContainerState();
}

class _TapToScaleContainerState extends State<TapToChangeColor> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    final Color color = isTapped ? Colors.orange : Colors.red;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 24,
        children: [
          AnimatedContainer(
            duration: Duration(seconds: 1),
            width: 200,
            height: 200,
            color: color,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isTapped = !isTapped;
              });
            },
            child: Text('Tap to change color'),
          ),
        ],
      ),
    );
  }
}
