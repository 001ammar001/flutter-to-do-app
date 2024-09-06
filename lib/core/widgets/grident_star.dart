import 'package:flutter/material.dart';

class GridentStar extends StatelessWidget {
  final Color startColor;
  final Color endColor;
  final double size;

  const GridentStar({
    super.key,
    required this.startColor,
    required this.endColor,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) => LinearGradient(
        stops: const [0.3, 1],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [startColor, endColor],
      ).createShader(bounds),
      child: Icon(Icons.star_rounded, size: size),
    );
  }
}
