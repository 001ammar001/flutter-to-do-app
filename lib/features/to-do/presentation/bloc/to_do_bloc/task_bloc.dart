import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/to-do/domin/entitys/task_entity.dart';
import 'package:to_do_app/features/to-do/domin/usecases/add_task_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/archive_task_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/delete_tasks_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/get_filtared_task_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/update_task_usecase.dart';

part 'task_states.dart';
part 'task_events.dart';

class TodosBloc extends Bloc<TodosEvents, TodosState> {
  final GetTasksUseCase getTasksUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final AddTaskUseCase addTasksUseCase;
  final DeleteTasksUseCase deleteTasksUseCase;
  final ArchiveTasksUseCase archiveTaskUseCase;

  TodosBloc({
    required this.getTasksUseCase,
    required this.addTasksUseCase,
    required this.deleteTasksUseCase,
    required this.archiveTaskUseCase,
    required this.updateTaskUseCase,
  }) : super(TodosState.inital()) {
    on<GetTodosEvent>(_getTodos);
    on<AddTodoEvent>(_addTodo);
    on<ArchiveTodosEvent>(_archiveTodos);
    on<DeleteTodosEvent>(_deleteTodos);
    on<UpdateTodoEvent>(_updateTodoEvent);
  }

  Future<void> _getTodos(GetTodosEvent event, Emitter emit) async {
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

  Future<void> _addTodo(AddTodoEvent event, Emitter emit) async {
    final taskOrError = await addTasksUseCase(event.taskEntity);
    taskOrError.fold(
      (left) => emit(
        state.copyWith(newState: TaskStatesEnum.failure, newTasks: []),
      ),
      (right) => add(GetTodosEvent(getActiveTasks: state.getPending)),
    );
  }

  Future<void> _updateTodoEvent(UpdateTodoEvent event, Emitter emit) async {
    final taskOrError = await updateTaskUseCase(event.taskEntity);
    taskOrError.fold(
      (left) => emit(
        state.copyWith(newState: TaskStatesEnum.failure, newTasks: []),
      ),
      (right) => add(GetTodosEvent(getActiveTasks: state.getPending)),
    );
  }

  Future<void> _archiveTodos(ArchiveTodosEvent event, Emitter emit) async {
    final taskOrError = await archiveTaskUseCase(event.ids);
    taskOrError.fold(
      (left) => emit(
        state.copyWith(newState: TaskStatesEnum.failure, newTasks: []),
      ),
      (right) => add(GetTodosEvent(getActiveTasks: state.getPending)),
    );
  }

  Future<void> _deleteTodos(DeleteTodosEvent event, Emitter emit) async {
    final taskOrError = await deleteTasksUseCase(event.ids);
    taskOrError.fold(
      (left) => emit(
        state.copyWith(newState: TaskStatesEnum.failure, newTasks: []),
      ),
      (right) => add(GetTodosEvent(getActiveTasks: state.getPending)),
    );
  }

  TodosState mapResultToState(dynamic result, TodosState state) {
    if (result.runtimeType == Failure) {
      return state.copyWith(newState: TaskStatesEnum.failure, newTasks: []);
    } else {
      return state;
    }
  }
}
