import 'package:animations_masterclass/src/features/explicit/custom_painter/bouncing_ball_animation.dart';
import 'package:animations_masterclass/src/features/explicit/custom_painter/bouncing_ball_optimized.dart';
import 'package:animations_masterclass/src/features/explicit/custom_painter/square_box.dart';
import 'package:animations_masterclass/src/features/explicit/custom_painter/two_half_circle.dart';
import 'package:animations_masterclass/src/features/explicit/logo_fade_animation.dart';
import 'package:animations_masterclass/src/features/explicit/staggered_animations/staggered_slide_animation.dart';
import 'package:animations_masterclass/src/features/implicit/inbuilt/tap_to_change_color.dart';
import 'package:animations_masterclass/src/features/implicit/inbuilt/tap_to_resize_container.dart';
import 'package:animations_masterclass/src/features/implicit/inbuilt/tap_to_scale_container.dart';
import 'package:animations_masterclass/src/features/implicit/tweenanimationbuilder/tap_to_resize_container.dart';
import 'package:animations_masterclass/src/features/implicit/tweenanimationbuilder/tween_animation_showcase.dart';
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
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 24,
            children: [
              TapToScaleContainer(),
              TapToChangeColor(),
              Builder(
                builder: (context) => ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TapToResizeContainer(),
                      ),
                    );
                  },
                  icon: Icon(Icons.animation),
                  label: Text('TweenAnimationBuilder'),
                ),
              ),
              Builder(
                builder: (context) => ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TapToResizeContainerAnimated(),
                      ),
                    );
                  },
                  icon: Icon(Icons.animation),
                  label: Text('AnimatedContainer'),
                ),
              ),
              Builder(
                builder: (context) => ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TweenAnimationShowcase(),
                      ),
                    );
                  },
                  icon: Icon(Icons.stars),
                  label: Text('⭐ Showcase (Best Example)'),
                ),
              ),

              Builder(
                builder: (context) => ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LogoFadeAnimation(),
                      ),
                    );
                  },
                  icon: Icon(Icons.animation),
                  label: Text('Logo Fade Animation'),
                ),
              ),

              Builder(
                builder: (context) => ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StaggeredSlideAnimation(),
                      ),
                    );
                  },
                  icon: Icon(Icons.animation),
                  label: Text('Staggered Slide Animation'),
                ),
              ),
              Builder(
                builder: (context) => ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BouncingBallAnimation(),
                      ),
                    );
                  },
                  icon: Icon(Icons.animation),
                  label: Text('Bouncing Ball Animation'),
                ),
              ),

              Builder(
                builder: (context) => ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BouncingBallOptimized(),
                      ),
                    );
                  },
                  icon: Icon(Icons.animation),
                  label: Text('Bouncing Ball Optimized'),
                ),
              ),

              Builder(
                builder: (context) => ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SquareBox()),
                    );
                  },
                  icon: Icon(Icons.animation),
                  label: Text('Square Box'),
                ),
              ),

              Builder(
                builder: (context) => ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TwoHalfCircle()),
                    );
                  },
                  icon: Icon(Icons.animation),
                  label: Text('Two Half Circle'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
