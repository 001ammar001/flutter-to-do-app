import 'package:either_dart/either.dart';
import 'package:to_do_app/core/errors/exceptions.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/to-do/data/data_sources/task_local_data_source.dart';
import 'package:to_do_app/features/to-do/data/models/tag_model.dart';
import 'package:to_do_app/features/to-do/data/models/task_model.dart';
import 'package:to_do_app/features/to-do/domin/entitys/task_entity.dart';
import 'package:to_do_app/features/to-do/domin/repositores/task_repositore.dart';

class TaskRepositoreImplementation implements TaskRepositore {
  final LocalDataSource localDataSource;

  TaskRepositoreImplementation({required this.localDataSource});

  @override
  Future<Either<Failure, void>> addTask(TaskEntity task) async {
    try {
      final taskModel = _mapEntityToModel(task);
      await localDataSource.addTask(taskModel);
      return const Right(null);
    } on DbException {
      return Left(DbFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateTask(TaskEntity task) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteTask(int id) async {
    try {
      await localDataSource.deleteTask(id);
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
  Future<Either<Failure, List<TaskEntity>>> getPendingTasks() async {
    try {
      final tasks = await localDataSource.getPendingTasks();
      return Right(tasks);
    } on DbException {
      return Left(DbFailure());
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getDoneTasks() async {
    try {
      final tasks = await localDataSource.getDoneTasks();
      return Right(tasks);
    } on DbException {
      return Left(DbFailure());
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getFilterdTasks() async {
    try {
      final tasks = await localDataSource.getFilterdTasks();
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

  TaskModel _mapEntityToModel(TaskEntity taskEntity) {
    return TaskModel(
      id: taskEntity.id,
      title: taskEntity.title,
      date: taskEntity.date,
      time: taskEntity.time,
      description: taskEntity.description,
      urgent: taskEntity.urgent,
      done: taskEntity.done,
      tags: taskEntity.tags
          .map(
            (tag) => TagModel(name: tag.name, color: tag.color),
          )
          .toList(),
    );
  }
}
