import 'package:either_dart/either.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/to-do/domin/entitys/task_entity.dart';

abstract class TaskRepositore {
  Future<Either<Failure, List<TodoEntity>>> getTasks(bool getActive);
  Future<Either<Failure, void>> addTask(TodoEntity task);
  Future<Either<Failure, void>> updateTask(TodoEntity task);
  Future<Either<Failure, void>> deleteTasks(List<int> ids);
  Future<Either<Failure, void>> archiveTasks(List<int> ids);
}
