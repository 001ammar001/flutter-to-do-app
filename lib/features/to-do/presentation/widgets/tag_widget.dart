import 'package:flutter/widgets.dart';
import 'package:to_do_app/features/to-do/domin/entitys/tag_entity.dart';

class TagWidget extends StatelessWidget {
  const TagWidget({
    super.key,
    required this.tag,
  });

  final TagEntity tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      margin: const EdgeInsets.only(right: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: tag.getTagColor(),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        tag.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: tag.getTextColor(),
        ),
      ),
    );
  }
}
