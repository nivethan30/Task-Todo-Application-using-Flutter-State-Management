import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo_list.dart';
import 'package:todo_app/provider/todo_provider.dart';
import 'package:todo_app/screens/add_todo.dart';
import 'package:todo_app/screens/edit_todo.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  //TextEditingController contentController = TextEditingController();

  final TodoProvider todoProvider = TodoProvider();

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() async {
    await Provider.of<TodoProvider>(context, listen: false).loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(builder: ((context, provider, child) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('TodoApp'),
        ),
        body: ListView.builder(
            itemCount: provider.todoList.length,
            itemBuilder: (context, index) {
              var todo = provider.todoList[index];
              return GestureDetector(
                onTap: () {
                  EditTodoBottomSheet().show(context, todo);
                },
                child: Card(
                  color: Colors.grey.shade700,
                  child: ListTile(
                    leading: IconButton(
                        onPressed: todo.isDone == false
                            ? () {
                                TodoList editedTodo = TodoList(
                                    id: DateTime.now.toString(),
                                    content: todo.content,
                                    isDone: true);
                                provider.editTodo(todo, editedTodo);
                              }
                            : () {
                                TodoList editedTodo = TodoList(
                                    id: DateTime.now.toString(),
                                    content: todo.content,
                                    isDone: false);
                                provider.editTodo(todo, editedTodo);
                              },
                        icon: todo.isDone == false
                            ? const Icon(Icons.check_box_outline_blank,
                                color: Colors.orange)
                            : const Icon(
                                Icons.check_box_outlined,
                                color: Colors.orange,
                              )),
                    title: Text(todo.content,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            decoration: todo.isDone == false
                                ? TextDecoration.none
                                : TextDecoration.lineThrough)),
                    trailing: IconButton(
                        onPressed: () {
                          provider.deleteTodo(todo);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        )),
                  ),
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AddTodoBottomSheet().show(context, (todo) {
              if (todo.isNotEmpty) {
                TodoList newTodo =
                    TodoList(id: DateTime.now.toString(), content: todo);
                provider.addTodo(newTodo);
              }
            });
          },
          child: const Icon(Icons.add),
        ),
      );
    }));
  }
}
