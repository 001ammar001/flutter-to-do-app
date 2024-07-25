import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/to-do/domin/entitys/task_entity.dart';
import 'package:to_do_app/features/to-do/domin/usecases/add_task_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/archive_task_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/delete_task_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/delete_tasks_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/get_archived_task_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/get_done_task_usecase.dart';

part 'task_states.dart';
part 'task_events.dart';

class TaskBloc extends Bloc<TaskEvents, TaskStates> {
  final GetDoneTasksUseCase getDoneTasksUseCase;
  final AddTaskUseCase addTasksUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final DeleteTasksUseCase deleteTasksUseCase;
  final GetPendindTasksUseCase getPendindTasksUseCase;
  final ArchiveTasksUseCase archiveTaskUseCase;

  TaskBloc({
    required this.getDoneTasksUseCase,
    required this.addTasksUseCase,
    required this.deleteTaskUseCase,
    required this.deleteTasksUseCase,
    required this.getPendindTasksUseCase,
    required this.archiveTaskUseCase,
  }) : super(TasksInitState()) {
    on<TaskEvents>(
      (event, emit) async {
        if (event is GetPedningTasksEvent) {
          emit(TasksLoadingState());
          final taskOrError = await getPendindTasksUseCase();
          emit(
            mapResultToState(
              taskOrError,
              TasksLodedState(taskEntity: taskOrError.right, active: true),
            ),
          );
        } else if (event is GetDoneTasksEvent) {
          emit(TasksLoadingState());
          final taskOrError = await getDoneTasksUseCase();
          emit(
            mapResultToState(
              taskOrError,
              TasksLodedState(taskEntity: taskOrError.right, active: false),
            ),
          );
        } else if (event is AddTaskEvent) {
          emit(TasksLoadingState());
          final addOrError = await addTasksUseCase(event.taskEntity);
          emit(
            mapResultToState(
              addOrError,
              TaskSucessState(message: "Task Addes Succesfully "),
            ),
          );
        } else if (event is DeleteTaskEvent) {
          emit(TasksLoadingState());
          final addOrError = await deleteTaskUseCase(event.id);
          emit(
            mapResultToState(
              addOrError,
              TaskSucessState(message: "Task Deleted Succesfully "),
            ),
          );
          add(GetPedningTasksEvent());
        } else if (event is ArchiveTasksEvent) {
          emit(TasksLoadingState());
          final addOrError = await archiveTaskUseCase(event.ids);
          emit(
            mapResultToState(
              addOrError,
              TaskSucessState(message: "Tasks Archived Succesfully "),
            ),
          );
          add(GetPedningTasksEvent());
        } else if (event is DeleteTasksEvent) {
          emit(TasksLoadingState());
          final addOrError = await deleteTasksUseCase(event.ids);
          emit(
            mapResultToState(
              addOrError,
              TaskSucessState(message: "Tasks Deleted Succesfully "),
            ),
          );
          add(GetPedningTasksEvent());
        }
      },
    );
  }

  TaskStates mapResultToState(dynamic entity, TaskStates state) {
    if (entity.runtimeType == Failure) {
      return TaskErrorState(message: "unKnown Error");
    } else {
      return state;
    }
  }
}
