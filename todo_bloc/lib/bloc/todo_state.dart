part of 'todo_bloc.dart';

@immutable
sealed class TodoState {
  final List<Todo> todos;

  const TodoState(this.todos);
}

final class TodoInitial extends TodoState {
  const TodoInitial(super.todos);
}

final class TodoLoading extends TodoState {
  const TodoLoading(super.todos);
}

final class TodoFailed extends TodoState {
  const TodoFailed(super.todos);
}

final class TodoSuccess extends TodoState {
  const TodoSuccess(super.todos);
}
