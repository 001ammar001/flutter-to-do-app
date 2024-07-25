import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/features/to-do/data/models/tag_model.dart';
import 'package:to_do_app/features/to-do/data/models/task_model.dart';

class DatabaseHelper {
  final Database database;

  const DatabaseHelper({required this.database});

  Future<void> addTask(TaskModel task) async {
    List jsonTags = task.tags.map((tag) {
      final tagModel = tag as TagModel;
      return tagModel.toJSon();
    }).toList();

    await database.insert('tasks', {
      "title": task.title,
      "date": task.date,
      "time": task.time,
      "description": task.description,
      "urgent": task.urgent,
      "done": task.done,
      "tags": jsonEncode(jsonTags),
    });
    return Future.value();
  }

  Future<List<TaskModel>> getPendindTasks() async {
    final data = await database.rawQuery(
      "SELECT * FROM tasks where tasks.done = 0",
    );
    return data.map((task) => TaskModel.fromJson(task)).toList();
  }

  Future<List<TaskModel>> getDoneTasks() async {
    final data = await database.rawQuery(
      "SELECT * FROM tasks where tasks.done = 1",
    );
    return data.map((task) => TaskModel.fromJson(task)).toList();
  }

  Future<List<TaskModel>> getFilterdTasks() async {
    final data = await database.rawQuery(
      "SELECT * FROM tasks where tasks.done = 1",
    );
    return data.map((task) => TaskModel.fromJson(task)).toList();
  }

  Future<void> deleteTask(int id) async {
    await database.rawDelete('DELETE FROM tasks WHERE taskId = $id');
  }

  Future<void> deleteTasks(List<int> ids) async {
    await database.rawDelete(
        'DELETE FROM tasks WHERE taskId IN (${ids.map((id) => id).toString()})');
  }

  Future<void> archiveTasks(List<int> ids) async {
    await database.rawUpdate(
        "Update tasks SET done = 1 WHERE taskId IN (${ids.map((id) => id).toString()})");
  }
}
