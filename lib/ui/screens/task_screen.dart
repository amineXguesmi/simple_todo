import 'package:flutter/material.dart';

import '../../core/services/task_service.dart';
import '../../core/shared/enums.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late TaskService taskService;
  @override
  void initState() {
    taskService = TaskService();

    super.initState();
    loadTasks();
  }

  loadTasks() async {
    await taskService.loadTasks();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            taskService.saveTasks();
          },
          child: const Icon(
            Icons.save,
            size: 50,
            color: Colors.greenAccent,
          ),
        ),
        title: const Text(
          'Task Screen',
        ),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: taskService.tasks.length,
            itemBuilder: (context, index) {
              final task = taskService.tasks[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ListTile(
                  title: Text(
                    task.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(task.description),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(task.date),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(task.status.toString()),
                      ],
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.done,
                          color: Colors.green,
                          size: 40,
                        ),
                        onPressed: () {
                          taskService.changeStatus(index, Status.completed);
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.timelapse_rounded,
                          color: Colors.grey,
                          size: 40,
                        ),
                        onPressed: () {
                          taskService.changeStatus(index, Status.inProgress);
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 40,
                        ),
                        onPressed: () {
                          taskService.deleteTask(index);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          taskService.addTask('title', 'description', 'date');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
