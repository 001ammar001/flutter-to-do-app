import 'package:either_dart/either.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/to-do/domin/repositores/task_repositore.dart';

class DeleteTaskUseCase {
  final TaskRepositore taskRepositore;

  DeleteTaskUseCase({required this.taskRepositore});

  Future<Either<Failure, void>> call(int id) async {
    return await taskRepositore.deleteTask(id);
  }
}
