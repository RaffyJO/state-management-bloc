// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/models/todo.dart';
import 'package:todo_bloc/views/widgets/dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  addTodo() {
    titleController.text = '';
    descriptionController.text = '';
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(20),
          children: [
            CustomDialog(
                titleController: titleController,
                descriptionController: descriptionController,
                onTap: () {
                  Todo newTodo =
                      Todo(titleController.text, descriptionController.text);
                  context.read<TodoBloc>().add(TodoAdd(newTodo));
                  Navigator.pop(context);
                  DInfo.snackBarSuccess(context, 'Added Success');
                },
                titleDialog: "Add"),
          ],
        );
      },
    );
  }

  updateTodo(int index, Todo oldTodo) {
    titleController.text = '';
    descriptionController.text = '';
    titleController.text = oldTodo.title;
    descriptionController.text = oldTodo.description;
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(20),
          children: [
            CustomDialog(
              titleController: titleController,
              descriptionController: descriptionController,
              onTap: () {
                Todo newTodo =
                    Todo(titleController.text, descriptionController.text);
                context.read<TodoBloc>().add(TodoUpdate(index, newTodo));
                Navigator.pop(context);
                DInfo.snackBarSuccess(context, 'Todo Updated');
              },
              titleDialog: 'Update',
            ),
          ],
        );
      },
    );
  }

  removeTodo(int index) {
    DInfo.dialogConfirmation(
      context,
      'Remove Todo',
      'Are you sure to remove this todo?',
    ).then((bool? yes) {
      if (yes ?? false) {
        context.read<TodoBloc>().add(TodoRemove(index));
        DInfo.snackBarSuccess(context, 'Todo Removed');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TodoSuccess) {
            List<Todo> todos = state.todos;
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                Todo todo = todos[index];
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(todo.title),
                      subtitle: Text(todo.description),
                      trailing: PopupMenuButton(
                        onSelected: (value) {
                          switch (value) {
                            case 'update':
                              updateTodo(index, todo);
                              break;
                            case 'remove':
                              removeTodo(index);
                              break;
                            default:
                              DInfo.snackBarError(context, 'Invalid Menu');
                              break;
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'update',
                            child: Text('Update'),
                          ),
                          const PopupMenuItem(
                            value: 'remove',
                            child: Text('Remove'),
                          ),
                        ],
                      ),
                    ),
                    const Divider()
                  ],
                );
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodo();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
