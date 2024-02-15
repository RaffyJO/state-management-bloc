part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class TodoAdd extends TodoEvent {
  final Todo newTodo;

  TodoAdd(this.newTodo);
}

class TodoUpdate extends TodoEvent {
  final int index;
  final Todo newTodo;

  TodoUpdate(this.index, this.newTodo);
}

class TodoRemove extends TodoEvent {
  final int index;

  TodoRemove(this.index);
}
