import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc/models/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoInitial([])) {
    on<TodoEvent>((event, emit) async {
      if (event is TodoAdd) {
        emit(TodoLoading(state.todos));
        await Future.delayed(const Duration(seconds: 1));
        Todo newTodo = event.newTodo;
        // List<Todo> currentTodos = state.todos;
        // currentTodos.add(newTodo);
        emit(TodoSuccess([...state.todos, newTodo]));
      }

      if (event is TodoUpdate) {
        Todo newTodo = event.newTodo;
        int index = event.index;
        List<Todo> currentTodos = state.todos;
        currentTodos[index] = newTodo;
        emit(TodoSuccess(currentTodos));
      }

      if (event is TodoRemove) {
        int index = event.index;
        List<Todo> currentTodos = state.todos;
        currentTodos.removeAt(index);
        emit(TodoSuccess(currentTodos));
      }
    });
  }
}
