part of 'task_bloc.dart';

enum TaskStatesEnum { loading, sucsess, failure, init }

class TasksState {
  final TaskStatesEnum state;
  final List<TodoEntity> tasks;
  final bool getPending;
  final String message;

  TasksState({
    required this.state,
    required this.tasks,
    required this.getPending,
    required this.message,
  });

  TasksState.inital({
    this.state = TaskStatesEnum.init,
    this.getPending = true,
    this.message = "",
    tasks,
  }) : tasks = (tasks != null) ? tasks : [];

  TasksState copyWith({
    TaskStatesEnum? newState,
    List<TodoEntity>? newTasks,
    bool? newGetActive,
    String? newMessage,
  }) {
    return TasksState(
      state: newState ?? state,
      tasks: newTasks ?? tasks,
      getPending: newGetActive ?? getPending,
      message: newMessage ?? message,
    );
  }

  bool get isLoading => state == TaskStatesEnum.loading;

  bool get isFailure => state == TaskStatesEnum.failure;

  bool get isSucsess => state == TaskStatesEnum.sucsess;
}
