import 'package:flutter/material.dart';
import 'package:to_do_app/core/theme/colors_mapper.dart';
import 'package:to_do_app/features/to-do/domin/entitys/tag_entity.dart';

class TagListItem extends StatelessWidget {
  final bool isChoosed;
  final TagEntity item;
  const TagListItem({super.key, required this.isChoosed, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: myColors[item.color].shade100,
        borderRadius: BorderRadius.circular(6),
        border: isChoosed ? Border.all(color: Colors.black, width: 2) : null,
      ),
      child: Text(
        item.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
