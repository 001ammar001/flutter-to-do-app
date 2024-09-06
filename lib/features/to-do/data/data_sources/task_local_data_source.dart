import 'package:to_do_app/core/database/database_helper.dart';
import 'package:to_do_app/core/errors/exceptions.dart';
import 'package:to_do_app/features/to-do/data/models/task_model.dart';

abstract class LocalDataSource {
  Future<List<TaskModel>> getTasks(bool getActive);
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
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
  Future<void> deleteTasks(List<int> ids) async {
    await _tryProtectedFunction(databaseHelper.deleteTasks(ids));
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    await _tryProtectedFunction(databaseHelper.updateTask(task));
  }

  @override
  Future<List<TaskModel>> getTasks(bool getActive) async {
    return await _tryProtectedFunction(databaseHelper.getTasks(getActive))
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
