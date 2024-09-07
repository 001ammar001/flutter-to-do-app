import 'package:either_dart/either.dart';
import 'package:to_do_app/core/errors/exceptions.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/to-do/data/data_sources/task_local_data_source.dart';
import 'package:to_do_app/features/to-do/data/models/task_model.dart';
import 'package:to_do_app/features/to-do/domin/entitys/task_entity.dart';
import 'package:to_do_app/features/to-do/domin/repositores/task_repositore.dart';

class TaskRepositoreImplementation implements TaskRepositore {
  final LocalDataSource localDataSource;

  TaskRepositoreImplementation({required this.localDataSource});

  @override
  Future<Either<Failure, void>> addTask(TodoEntity task) async {
    try {
      final taskModel = TodoModel.fromEntity(task);
      await localDataSource.addTask(taskModel);
      return const Right(null);
    } on DbException {
      return Left(DbFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateTask(TodoEntity task) async {
    try {
      final taskModel = TodoModel.fromEntity(task);
      await localDataSource.updateTask(taskModel);
      return const Right(null);
    } on DbException {
      return Left(DbFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTasks(List<int> ids) async {
    try {
      await localDataSource.deleteTasks(ids);
      return const Right(null);
    } on DbException {
      return Left(DbFailure());
    }
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> getTasks(bool getActive) async {
    try {
      final tasks = await localDataSource.getTasks(getActive);
      return Right(tasks);
    } on DbException {
      return Left(DbFailure());
    }
  }

  @override
  Future<Either<Failure, void>> archiveTasks(List<int> ids) async {
    try {
      await localDataSource.archiveTasks(ids);
      return const Right(null);
    } on DbException {
      return Left(DbFailure());
    }
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> getAllTasks() async {
    try {
      final results = await localDataSource.getAllTasks();
      return Right(results);
    } on DbException {
      return Left(DbFailure());
    }
  }
}
