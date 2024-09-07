import 'package:either_dart/either.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/to-do/domin/entitys/task_entity.dart';
import 'package:to_do_app/features/to-do/domin/repositores/task_repositore.dart';

class GetTasksUseCase {
  final TaskRepositore taskRepositore;

  GetTasksUseCase({required this.taskRepositore});

  Future<Either<Failure, List<TodoEntity>>> call(bool getActive) async {
    return await taskRepositore.getTasks(getActive);
  }
}
