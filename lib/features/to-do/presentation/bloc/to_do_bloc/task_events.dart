part of 'task_bloc.dart';

abstract class TodosEvents {}

class GetTodosEvent extends TodosEvents {
  final bool? getActiveTasks;

  GetTodosEvent({this.getActiveTasks});
}

class UpdateTodoEvent extends TodosEvents {
  final TodoEntity taskEntity;

  UpdateTodoEvent({required this.taskEntity});
}

class AddTodoEvent extends TodosEvents {
  final TodoEntity taskEntity;

  AddTodoEvent({required this.taskEntity});
}

class DeleteTodosEvent extends TodosEvents {
  final List<int> ids;

  DeleteTodosEvent({required this.ids});
}

class ArchiveTodosEvent extends TodosEvents {
  final List<int> ids;

  ArchiveTodosEvent({required this.ids});
}
