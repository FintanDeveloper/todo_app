import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Components/my_button.dart';
import 'package:todo/Database/todo_database.dart';
import 'package:todo/Models/todo.dart';
import 'package:todo/constants.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add Task'),
        titleTextStyle:
            const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        backgroundColor: darkPurple,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            size: 36,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(resHeight(20, context)),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontSize: resHeight(14, context)),
                    labelText: 'Title',
                    labelStyle: TextStyle(
                      fontSize: resHeight(20, context),
                      color: darkPurple,
                    ),
                    enabled: true,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(resHeight(16, context)),
                      borderSide: const BorderSide(color: lightPurple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(resHeight(16, context)),
                      borderSide: const BorderSide(color: lightPurple),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(resHeight(16, context)),
                      borderSide: const BorderSide(color: lightPurple),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(resHeight(16, context)),
                      borderSide: const BorderSide(color: lightPurple),
                    ),
                  ),
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Title can\'t be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: resHeight(24, context),
                ),
                TextFormField(
                  controller: detailsController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 10,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontSize: resHeight(14, context)),
                    labelText: 'Details',
                    labelStyle: TextStyle(
                        fontSize: resHeight(20, context), color: darkPurple),
                    enabled: true,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(resHeight(16, context)),
                      borderSide: const BorderSide(color: lightPurple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(resHeight(16, context)),
                      borderSide: const BorderSide(color: lightPurple),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(resHeight(16, context)),
                      borderSide: const BorderSide(color: lightPurple),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(resHeight(16, context)),
                      borderSide: const BorderSide(color: lightPurple),
                    ),
                  ),
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Details can\'t be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: resHeight(24, context),
                ),
                MyButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        Todo newTodo = Todo(
                          title: titleController.text.trim(),
                          details: detailsController.text.trim(),
                          dateTime: DateTime.now(),
                        );
                        await context.read<TodoDatabase>().createTodo(newTodo);
                        Navigator.pop(context);
                      }
                    },
                    title: 'ADD'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
