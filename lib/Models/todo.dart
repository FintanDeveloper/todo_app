import 'package:isar/isar.dart';

part 'todo.g.dart';

@Collection()
class Todo {
  Id id = Isar.autoIncrement;
  final String title;
  final String details;
  final DateTime dateTime;
  final bool isComplete;

  Todo({
    required this.title,
    required this.details,
    required this.dateTime,
    this.isComplete = false,
  });
}
