part of 'task_bloc.dart';

enum TaskStatesEnum { loading, sucsess, failure, init }

class TodosState {
  final TaskStatesEnum state;
  final List<TodoEntity> tasks;
  final bool getPending;
  final String message;

  TodosState({
    required this.state,
    required this.tasks,
    required this.getPending,
    required this.message,
  });

  TodosState.inital({
    this.state = TaskStatesEnum.init,
    this.getPending = true,
    this.message = "",
    tasks,
  }) : tasks = (tasks != null) ? tasks : [];

  TodosState copyWith({
    TaskStatesEnum? newState,
    List<TodoEntity>? newTasks,
    bool? newGetActive,
    String? newMessage,
  }) {
    return TodosState(
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
