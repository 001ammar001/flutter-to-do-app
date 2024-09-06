import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/features/to-do/data/models/tag_model.dart';
import 'package:to_do_app/features/to-do/data/models/task_model.dart';

class DatabaseHelper {
  static late Database database;
  static const _databaseName = "toDo.db";
  static const _databaseVersion = 1;

  const DatabaseHelper();

  static init() async {
    database = await openDatabase(
      _databaseName,
      version: _databaseVersion,
      onConfigure: (db) => db.execute("PRAGMA foreign_keys = ON"),
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE tasks (
            taskId INTEGER PRIMARY KEY,
            title TEXT NOT NULL,
            date TEXT NOT NULL,
            time TEXT NOT NULL,
            description TEXT NOT NULL,
            urgent INTEGER NOT NULL,
            done INTEGER NOT NULL,
            tags TEXT NOT NULL
          )
          ''');
      },
    );
  }

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

  Future<void> updateTask(TaskModel task) async {
    List jsonTags = task.tags.map((tag) {
      final tagModel = tag as TagModel;
      return tagModel.toJSon();
    }).toList();

    await database.update(
      'tasks',
      where: "tasks.taskId = ?",
      whereArgs: [task.id],
      {
        "title": task.title,
        "date": task.date,
        "time": task.time,
        "description": task.description,
        "urgent": task.urgent,
        "done": task.done,
        "tags": jsonEncode(jsonTags),
      },
    );
    return Future.value();
  }

  Future<List<TaskModel>> getTasks(bool getActive) async {
    final data = await database.query(
      "tasks",
      where: "tasks.done = ?",
      whereArgs: [getActive ? 0 : 1],
    );
    return data.map((task) => TaskModel.fromJson(task)).toList();
  }

  Future<void> deleteTasks(List<int> ids) async {
    await database.rawDelete(
        'DELETE FROM tasks WHERE taskId IN ${ids.map((id) => id).toString()}');
  }

  Future<void> archiveTasks(List<int> ids) async {
    await database.rawUpdate(
        "Update tasks SET done = 1 WHERE taskId IN ${ids.map((id) => id).toString()}");
  }
}
