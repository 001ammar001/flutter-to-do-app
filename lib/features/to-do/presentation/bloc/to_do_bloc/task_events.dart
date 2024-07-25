part of 'task_bloc.dart';

abstract class TaskEvents {}

class GetDoneTasksEvent extends TaskEvents {}

class GetPedningTasksEvent extends TaskEvents {}

class AddTaskEvent extends TaskEvents {
  final TaskEntity taskEntity;

  AddTaskEvent({required this.taskEntity});
}

class DeleteTaskEvent extends TaskEvents {
  final int id;

  DeleteTaskEvent({required this.id});
}

class DeleteTasksEvent extends TaskEvents {
  final List<int> ids;

  DeleteTasksEvent({required this.ids});
}

class ArchiveTasksEvent extends TaskEvents {
  final List<int> ids;

  ArchiveTasksEvent({required this.ids});
}
