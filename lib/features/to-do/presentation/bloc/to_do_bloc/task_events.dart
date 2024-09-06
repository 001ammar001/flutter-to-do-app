part of 'task_bloc.dart';

abstract class TaskEvents {}

class GetTasksEvent extends TaskEvents {
  final bool? getActiveTasks;

  GetTasksEvent({this.getActiveTasks});
}

class UpdateTaskEvent extends TaskEvents {
  final TodoEntity taskEntity;

  UpdateTaskEvent({required this.taskEntity});
}

class AddTaskEvent extends TaskEvents {
  final TodoEntity taskEntity;

  AddTaskEvent({required this.taskEntity});
}

class DeleteTasksEvent extends TaskEvents {
  final List<int> ids;

  DeleteTasksEvent({required this.ids});
}

class ArchiveTasksEvent extends TaskEvents {
  final List<int> ids;

  ArchiveTasksEvent({required this.ids});
}
