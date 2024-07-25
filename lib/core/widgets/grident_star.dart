import 'package:flutter/material.dart';

Widget gridentIconStar({
  required startColor,
  required endColor,
  size = 40.0,
}) =>
    ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) => LinearGradient(
        stops: const [0.3, 1],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [startColor, endColor],
      ).createShader(bounds),
      child: Icon(Icons.star_rounded, size: size),
    );
