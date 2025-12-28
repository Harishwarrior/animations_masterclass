import 'package:animations_masterclass/src/features/implicit/inbuilt/tap_to_change_color.dart';
import 'package:animations_masterclass/src/features/implicit/inbuilt/tap_to_scale_container.dart';
import 'package:animations_masterclass/src/features/implicit/tweenanimationbuilder/tap_to_resize_container.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          spacing: 24,
          children: [
            TapToScaleContainer(),
            TapToChangeColor(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TapToResizeContainer(),
                  ),
                );
              },
              child: Icon(Icons.animation),
            ),
          ],
        ),
      ),
    );
  }
}
