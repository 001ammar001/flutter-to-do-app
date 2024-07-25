import 'package:to_do_app/core/database/database_helper.dart';
import 'package:to_do_app/core/errors/exceptions.dart';
import 'package:to_do_app/features/to-do/data/models/task_model.dart';

abstract class LocalDataSource {
  Future<List<TaskModel>> getPendingTasks();
  Future<List<TaskModel>> getDoneTasks();
  Future<List<TaskModel>> getFilterdTasks();
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(int id);
  Future<void> deleteTasks(List<int> ids);
  Future<void> archiveTasks(List<int> ids);
}

class SqfliteLocalDataSource extends LocalDataSource {
  final DatabaseHelper databaseHelper;

  SqfliteLocalDataSource({required this.databaseHelper});

  @override
  Future<void> addTask(TaskModel task) async {
    await _tryProtectedFunction(databaseHelper.addTask(task));
  }

  @override
  Future<void> archiveTasks(List<int> ids) async {
    await _tryProtectedFunction(databaseHelper.archiveTasks(ids));
  }

  @override
  Future<void> deleteTask(int id) async {
    await _tryProtectedFunction(databaseHelper.deleteTask(id));
  }

  @override
  Future<void> deleteTasks(List<int> ids) async {
    await _tryProtectedFunction(databaseHelper.deleteTasks(ids));
  }

  @override
  Future<List<TaskModel>> getPendingTasks() async {
    return await _tryProtectedFunction(databaseHelper.getPendindTasks())
        as List<TaskModel>;
  }

  @override
  Future<void> updateTask(TaskModel task) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }

  @override
  Future<List<TaskModel>> getDoneTasks() async {
    return await _tryProtectedFunction(databaseHelper.getDoneTasks())
        as List<TaskModel>;
  }

  @override
  Future<List<TaskModel>> getFilterdTasks() async {
    return await _tryProtectedFunction(databaseHelper.getFilterdTasks())
        as List<TaskModel>;
  }

  Future _tryProtectedFunction(Future function) async {
    try {
      return await function;
    } on Exception {
      throw DbException();
    }
  }
}
