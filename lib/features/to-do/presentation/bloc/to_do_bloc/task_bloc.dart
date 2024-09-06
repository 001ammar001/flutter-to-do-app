import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/to-do/domin/entitys/task_entity.dart';
import 'package:to_do_app/features/to-do/domin/usecases/add_task_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/archive_task_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/delete_tasks_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/get_done_task_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/update_task_usecase.dart';

part 'task_states.dart';
part 'task_events.dart';

class TasksBloc extends Bloc<TaskEvents, TasksState> {
  final GetTasksUseCase getTasksUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final AddTaskUseCase addTasksUseCase;
  final DeleteTasksUseCase deleteTasksUseCase;
  final ArchiveTasksUseCase archiveTaskUseCase;

  TasksBloc({
    required this.getTasksUseCase,
    required this.addTasksUseCase,
    required this.deleteTasksUseCase,
    required this.archiveTaskUseCase,
    required this.updateTaskUseCase,
  }) : super(TasksState.inital()) {
    on<GetTasksEvent>(_getTasks);
    on<AddTaskEvent>(_addTask);
    on<ArchiveTasksEvent>(_archiveTasks);
    on<DeleteTasksEvent>(_deleteTasks);
    on<UpdateTaskEvent>(_updateTaskEvent);
  }

  Future<void> _getTasks(GetTasksEvent event, Emitter emit) async {
    emit(state.copyWith(
      newState: TaskStatesEnum.loading,
      newGetActive: event.getActiveTasks,
    ));

    final taskOrError = await getTasksUseCase(state.getPending);

    emit(
      mapResultToState(
        taskOrError,
        state.copyWith(
          newTasks: taskOrError.right,
          newState: TaskStatesEnum.sucsess,
        ),
      ),
    );
  }

  Future<void> _addTask(AddTaskEvent event, Emitter emit) async {
    final taskOrError = await addTasksUseCase(event.taskEntity);
    taskOrError.fold(
      (left) => emit(
        state.copyWith(newState: TaskStatesEnum.failure, newTasks: []),
      ),
      (right) => add(GetTasksEvent(getActiveTasks: state.getPending)),
    );
  }

  Future<void> _updateTaskEvent(UpdateTaskEvent event, Emitter emit) async {
    final taskOrError = await updateTaskUseCase(event.taskEntity);
    taskOrError.fold(
      (left) => emit(
        state.copyWith(newState: TaskStatesEnum.failure, newTasks: []),
      ),
      (right) => add(GetTasksEvent(getActiveTasks: state.getPending)),
    );
  }

  Future<void> _archiveTasks(ArchiveTasksEvent event, Emitter emit) async {
    final taskOrError = await archiveTaskUseCase(event.ids);
    taskOrError.fold(
      (left) => emit(
        state.copyWith(newState: TaskStatesEnum.failure, newTasks: []),
      ),
      (right) => add(GetTasksEvent(getActiveTasks: state.getPending)),
    );
  }

  Future<void> _deleteTasks(DeleteTasksEvent event, Emitter emit) async {
    final taskOrError = await deleteTasksUseCase(event.ids);
    taskOrError.fold(
      (left) => emit(
        state.copyWith(newState: TaskStatesEnum.failure, newTasks: []),
      ),
      (right) => add(GetTasksEvent(getActiveTasks: state.getPending)),
    );
  }

  TasksState mapResultToState(dynamic result, TasksState state) {
    if (result.runtimeType == Failure) {
      return state.copyWith(newState: TaskStatesEnum.failure, newTasks: []);
    } else {
      return state;
    }
  }
}
