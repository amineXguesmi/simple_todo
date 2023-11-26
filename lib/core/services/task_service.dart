import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop4/core/models/task.dart';
import 'package:workshop4/core/shared/enums.dart';

class TaskService {
  List<Task> tasks = [];

  Task _createTask(String title, String description, String date, Status status) {
    return Task(
      title: title,
      description: description,
      date: date,
      status: status,
    );
  }

  void addTask(String title, String description, String date) {
    tasks.add(_createTask('title', 'description', 'date', Status.toDo));
  }

  void deleteTask(int index) async {
    tasks.removeAt(index);
  }

  void changeStatus(int index, Status status) async {
    tasks[index].status = status;
  }

  void saveTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> taskList = tasks.map((task) => jsonEncode(task.toMap())).toList();
    prefs.setStringList('taskList', taskList);
  }

  Future<void> loadTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? taskList = prefs.getStringList('taskList');
    if (taskList != null) {
      tasks = taskList.map((taskJson) => Task.fromMap(jsonDecode(taskJson))).toList();
    }
  }
}
