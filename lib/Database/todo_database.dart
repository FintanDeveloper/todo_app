import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/Models/todo.dart';

class TodoDatabase extends ChangeNotifier {
  static late Isar isar;
  List<Todo> _allTodos = [];

  /*
  
  S E T U P

  */

  // initialize db
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([TodoSchema], directory: dir.path);
  }

  /*
  
  G E T T E R S

  */

  List<Todo> get allTodos => _allTodos;

  /*
  
  O P E R A T I O N S

  */

  // Create - add a new todo
  Future<int> createTodo(Todo newTodo) async {
    // add to db
    var id = await isar.writeTxn(() => isar.todos.put(newTodo));

    // re-read from db
    await readTodos();
    return id;
  }

  // Read Todos from db
  Future<void> readTodos() async {
    // fetch all existing todos from db
    List<Todo> fetchedTodos = await isar.todos.where().findAll();

    // give to local todo list
    _allTodos.clear();
    _allTodos.addAll(fetchedTodos);

    // update the ui
    notifyListeners();
  }

  // Update - edit an existing todo in db
  Future<void> updateTodo(int id, Todo updatedTodo) async {
    // make sure new todo has the same id as existing one
    updatedTodo.id = id;

    // update in db
    await isar.writeTxn(() => isar.todos.put(updatedTodo));

    // re-read from db
    await readTodos();
  }

  // Delete a todo
  Future<void> deleteTodo(int id) async {
    // delete a todo from db
    await isar.writeTxn(() => isar.todos.delete(id));

    // re-read from db
    await readTodos();
  }
}
