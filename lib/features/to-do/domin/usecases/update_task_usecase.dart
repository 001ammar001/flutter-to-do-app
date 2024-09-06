import 'package:either_dart/either.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/to-do/domin/entitys/task_entity.dart';
import 'package:to_do_app/features/to-do/domin/repositores/task_repositore.dart';

class UpdateTaskUseCase {
  final TaskRepositore taskRepositore;

  UpdateTaskUseCase({required this.taskRepositore});

  Future<Either<Failure, void>> call(TodoEntity taskEntity) async {
    return await taskRepositore.updateTask(taskEntity);
  }
}
