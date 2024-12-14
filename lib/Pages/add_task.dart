import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/Components/my_button.dart';
import 'package:todo/Database/todo_database.dart';
import 'package:todo/Models/todo.dart';
import 'package:todo/Service/notification_service.dart';
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
  DateTime scheduledTime = DateTime.now();
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
      body: Padding(
        padding: EdgeInsets.all(resHeight(20, context)),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: resHeight(10, context),
                      ),
                      TextFormField(
                        controller: titleController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          errorStyle:
                              TextStyle(fontSize: resHeight(14, context)),
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
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
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
                          errorStyle:
                              TextStyle(fontSize: resHeight(14, context)),
                          labelText: 'Details',
                          labelStyle: TextStyle(
                              fontSize: resHeight(20, context),
                              color: darkPurple),
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
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Details can\'t be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: resHeight(12, context),
                      ),
                      Text(
                        'Set a reminder',
                        style: TextStyle(
                          fontSize: resHeight(20, context),
                          color: darkPurple,
                        ),
                      ),
                      SizedBox(
                        height: resHeight(12, context),
                      ),
                      Container(
                        padding: EdgeInsets.all(
                          resHeight(10, context),
                        ),
                        decoration: BoxDecoration(
                          color: lightPurple,
                          borderRadius: BorderRadius.circular(
                            resHeight(15, context),
                          ),
                        ),
                        height: resHeight(55, context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pick a time',
                              style: TextStyle(
                                fontSize: resHeight(20, context),
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                DatePicker.showDateTimePicker(
                                  context,
                                  onConfirm: (time) {
                                    setState(() {
                                      scheduledTime = time;
                                    });
                                  },
                                );
                              },
                              child: Text(
                                DateFormat('dd-MM-yyyy hh:mm a')
                                    .format(scheduledTime),
                                style: TextStyle(
                                  fontSize: resHeight(14, context),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: resHeight(24, context),
                      ),
                    ],
                  ),
                ),
              ),
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
                    scheduledTime: scheduledTime,
                  );
                  var id =
                      await context.read<TodoDatabase>().createTodo(newTodo);
                  if (scheduledTime.isAfter(DateTime.now())) {
                    await NotificationService.scheduleNotification(
                        id,
                        titleController.text.trim(),
                        detailsController.text.trim(),
                        scheduledTime);
                  }

                  Navigator.pop(context);
                }
              },
              title: 'ADD',
            ),
          ],
        ),
      ),
    );
  }
}
