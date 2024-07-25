import 'package:either_dart/either.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/to-do/domin/entitys/task_entity.dart';
import 'package:to_do_app/features/to-do/domin/repositores/task_repositore.dart';

class GetFilterdTasksUseCase {
  final TaskRepositore taskRepositore;

  GetFilterdTasksUseCase({required this.taskRepositore});

  Future<Either<Failure, List<TaskEntity>>> call() async {
    return await taskRepositore.getFilterdTasks();
  }
}
