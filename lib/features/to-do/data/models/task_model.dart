import 'dart:convert';
import 'package:to_do_app/features/to-do/data/models/tag_model.dart';
import 'package:to_do_app/features/to-do/domin/entitys/task_entity.dart';

class TaskModel extends TodoEntity {
  TaskModel({
    super.id,
    required super.title,
    required super.date,
    required super.time,
    required super.description,
    required super.urgent,
    required super.done,
    required super.tags,
  });

  factory TaskModel.fromJson(Map<String, dynamic> map) {
    final tagsList = jsonDecode(map["tags"]) as List;

    return TaskModel(
      id: map["taskId"],
      title: map["title"],
      date: map["date"],
      time: map["time"],
      description: map["description"],
      urgent: map["urgent"],
      done: map["done"],
      tags: tagsList.map((tag) {
        return TagModel.fromJson(tag);
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "date": date,
      "time": time,
      "description": description,
      "urgent": urgent,
      "done": done,
      "tags": tags,
    };
  }
}
