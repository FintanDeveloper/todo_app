import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Components/todo_tile.dart';
import 'package:todo/Database/todo_database.dart';
import 'package:todo/Models/todo.dart';
import 'package:todo/Pages/add_task.dart';
import 'package:todo/Pages/edit_task.dart';
import 'package:todo/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<TodoDatabase>(context, listen: false).readTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoDatabase>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: lightPurpleScaffoldColor,
        appBar: AppBar(
          title: const Text('TODO APP'),
          titleTextStyle:
              const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          backgroundColor: darkPurple,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: value.allTodos.length,
            itemBuilder: (context, index) {
              Todo individualTodo = value.allTodos[index];
              return TodoTile(
                title: individualTodo.title,
                subTitle: individualTodo.details,
                isComplete: individualTodo.isComplete,
                onEditPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTask(
                        todo: value.allTodos[index],
                      ),
                    ),
                  );
                },
                onDeletePressed: () {
                  deleteTodoDialog(value.allTodos[index].id);
                },
                onStatusPressed: () async {
                  Todo updatedTodo = Todo(
                      title: value.allTodos[index].title,
                      details: value.allTodos[index].details,
                      dateTime: value.allTodos[index].dateTime,
                      scheduledTime: value.allTodos[index].scheduledTime,
                      isComplete: !value.allTodos[index].isComplete);
                  await context
                      .read<TodoDatabase>()
                      .updateTodo(value.allTodos[index].id, updatedTodo);
                },
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: darkPurple,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddTask(),
              ),
            );
          },
          child: const Icon(
            Icons.add,
            size: 32,
          ),
        ),
      ),
    );
  }

  void deleteTodoDialog(int id) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: darkPurple,
            title: const Text('Are you sure you want to delete this task?'),
            titleTextStyle: const TextStyle(fontSize: 24, color: Colors.white),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: lightPurple,
                    foregroundColor: Colors.white),
                child: Text('No',
                    style: TextStyle(fontSize: resHeight(16, context))),
              ),
              ElevatedButton(
                onPressed: () async {
                  await context.read<TodoDatabase>().deleteTodo(id);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: lightPurple,
                    foregroundColor: Colors.white),
                child: Text(
                  'Yes',
                  style: TextStyle(fontSize: resHeight(16, context)),
                ),
              )
            ],
          );
        });
  }
}
