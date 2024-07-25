import 'package:either_dart/either.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/to-do/domin/entitys/task_entity.dart';
import 'package:to_do_app/features/to-do/domin/repositores/task_repositore.dart';

class GetPendindTasksUseCase {
  final TaskRepositore taskRepositore;

  GetPendindTasksUseCase({required this.taskRepositore});

  Future<Either<Failure, List<TaskEntity>>> call() async {
    return await taskRepositore.getPendingTasks();
  }
}
