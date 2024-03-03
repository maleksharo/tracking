import 'dart:ui';

import 'package:flutter/material.dart';

class BlurFilter extends StatelessWidget {
  final Widget child;
  final double sigmaX;
  final double sigmaY;

  const BlurFilter({super.key, required this.child, this.sigmaX = 3.0, this.sigmaY = 3.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: sigmaX,
              sigmaY: sigmaY,
            ),
            child: Opacity(
              opacity: 0.01,
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
