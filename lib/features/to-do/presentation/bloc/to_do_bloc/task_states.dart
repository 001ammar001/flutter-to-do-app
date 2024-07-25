part of 'task_bloc.dart';

abstract class TaskStates {}

class TasksInitState extends TaskStates {}

class TasksLoadingState extends TaskStates {}

class TasksLodedState extends TaskStates {
  final List<TaskEntity> taskEntity;
  final bool active;

  TasksLodedState({required this.taskEntity, required this.active});
}

class TaskErrorState extends TaskStates {
  final String message;

  TaskErrorState({required this.message});
}

class TaskSucessState extends TaskStates {
  final String message;

  TaskSucessState({required this.message});
}
