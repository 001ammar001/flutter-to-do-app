import 'package:to_do_app/core/database/database_helper.dart';
import 'package:to_do_app/core/errors/exceptions.dart';
import 'package:to_do_app/features/to-do/data/models/task_model.dart';

abstract class LocalDataSource {
  Future<List<TodoModel>> getTasks(bool getActive);
  Future<List<TodoModel>> getAllTasks();
  Future<void> addTask(TodoModel task);
  Future<void> updateTask(TodoModel task);
  Future<void> deleteTasks(List<int> ids);
  Future<void> archiveTasks(List<int> ids);
}

class SqfliteLocalDataSource extends LocalDataSource {
  final DatabaseHelper databaseHelper;

  SqfliteLocalDataSource({required this.databaseHelper});

  @override
  Future<void> addTask(TodoModel task) async {
    await _tryProtectedFunction(databaseHelper.addTask(task));
  }

  @override
  Future<void> archiveTasks(List<int> ids) async {
    await _tryProtectedFunction(databaseHelper.archiveTasks(ids));
  }

  @override
  Future<void> deleteTasks(List<int> ids) async {
    await _tryProtectedFunction(databaseHelper.deleteTasks(ids));
  }

  @override
  Future<void> updateTask(TodoModel task) async {
    await _tryProtectedFunction(databaseHelper.updateTask(task));
  }

  @override
  Future<List<TodoModel>> getTasks(bool getActive) async {
    return await _tryProtectedFunction(databaseHelper.getTasks(getActive))
        as List<TodoModel>;
  }

  @override
  Future<List<TodoModel>> getAllTasks() async {
    return await _tryProtectedFunction(databaseHelper.getAllTasks())
        as List<TodoModel>;
  }

  Future _tryProtectedFunction(Future function) async {
    try {
      return await function;
    } on Exception {
      throw DbException();
    }
  }
}
