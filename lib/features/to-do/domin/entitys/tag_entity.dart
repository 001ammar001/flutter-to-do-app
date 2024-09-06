import 'package:flutter/material.dart';
import 'package:to_do_app/core/theme/colors_mapper.dart';

class TagEntity {
  final String name;
  final String color;

  TagEntity({
    required this.name,
    required this.color,
  });

  Color getTagColor() {
    return color == "black" ? Colors.black : tagColors[color].shade200;
  }

  Color getTextColor() {
    return color == "black" ? Colors.white : Colors.black;
  }
}
