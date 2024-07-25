import 'package:to_do_app/features/to-do/domin/entitys/tag_entity.dart';

class TaskEntity {
  final int? id;
  final String title;
  final String date;
  final String time;
  final String description;
  final int urgent;
  final int done;
  final List<TagEntity> tags;

  TaskEntity(
      {this.id,
      required this.title,
      required this.date,
      required this.time,
      required this.description,
      required this.urgent,
      required this.done,
      required this.tags});
}
