part of 'stats_bloc.dart';

enum StatsStatesEnum { loading, sucsess, failure, init }

class StatsState {
  final StatsStatesEnum state;
  final List<TodoEntity> tasks;
  final String message;

  StatsState({
    required this.state,
    required this.tasks,
    required this.message,
  });

  StatsState.inital({
    this.state = StatsStatesEnum.init,
    this.message = "",
    tasks,
  }) : tasks = (tasks != null) ? tasks : [];

  StatsState copyWith({
    StatsStatesEnum? newState,
    List<TodoEntity>? newTasks,
    bool? newGetActive,
    String? newMessage,
  }) {
    return StatsState(
      state: newState ?? state,
      tasks: newTasks ?? tasks,
      message: newMessage ?? message,
    );
  }

  bool get isLoading => state == StatsStatesEnum.loading;

  bool get isFailure => state == StatsStatesEnum.failure;

  bool get isSucsess => state == StatsStatesEnum.sucsess;

  int get doneTasksCount => tasks.where((element) => element.done == 1).length;

  Map<String, int> get tagsDest {
    var data = <String, int>{};
    for (var task in tasks) {
      for (var tag in task.tags) {
        if (data.containsKey(tag.name)) {
          data[tag.name] = data[tag.name]! + 1;
        } else {
          data[tag.name] = 1;
        }
      }
    }
    return data;
  }
}
