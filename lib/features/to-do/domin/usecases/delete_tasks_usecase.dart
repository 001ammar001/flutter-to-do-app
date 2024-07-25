import 'package:either_dart/either.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/to-do/domin/repositores/task_repositore.dart';

class DeleteTasksUseCase {
  final TaskRepositore taskRepositore;
  const DeleteTasksUseCase({required this.taskRepositore});

  Future<Either<Failure, void>> call(List<int> ids) async {
    return await taskRepositore.deleteTasks(ids);
  }
}
