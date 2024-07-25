import 'package:either_dart/either.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/to-do/domin/entitys/task_entity.dart';

abstract class TaskRepositore {
  Future<Either<Failure, List<TaskEntity>>> getPendingTasks();
  Future<Either<Failure, List<TaskEntity>>> getDoneTasks();
  Future<Either<Failure, List<TaskEntity>>> getFilterdTasks();
  Future<Either<Failure, void>> addTask(TaskEntity task);
  Future<Either<Failure, void>> updateTask(TaskEntity task);
  Future<Either<Failure, void>> deleteTask(int id);
  Future<Either<Failure, void>> deleteTasks(List<int> ids);
  Future<Either<Failure, void>> archiveTasks(List<int> ids);
}
