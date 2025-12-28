import 'package:flutter/material.dart';

class TapToScaleContainer extends StatefulWidget {
  const TapToScaleContainer({super.key});

  @override
  State<TapToScaleContainer> createState() => _TapToScaleContainerState();
}

class _TapToScaleContainerState extends State<TapToScaleContainer> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    final double size = isTapped ? 200 : 100;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 24,
        children: [
          AnimatedContainer(
            duration: Duration(seconds: 1),
            width: size,
            height: size,
            color: Colors.orange,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isTapped = !isTapped;
              });
            },
            child: Text('Tap to scale'),
          ),
        ],
      ),
    );
  }
}
