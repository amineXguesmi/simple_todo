import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/shared/enums.dart';
import '../../core/viewModels/task_viewModel.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late TaskViewModel taskViewModel;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController dateController;
  @override
  void initState() {
    super.initState();
    taskViewModel = context.read<TaskViewModel>();
    loadTasks();
    titleController = TextEditingController();
    dateController = TextEditingController();
    descriptionController = TextEditingController();
  }

  loadTasks() async {
    await taskViewModel.loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            taskViewModel.saveTasks();
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
        child: Consumer<TaskViewModel>(
          builder: (context, taskVm, child) {
            return ListView.builder(
                itemCount: taskVm.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskVm.tasks[index];
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
                              taskVm.changeStatus(index, Status.completed);
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.timelapse_rounded,
                              color: Colors.grey,
                              size: 40,
                            ),
                            onPressed: () {
                              taskVm.changeStatus(index, Status.inProgress);
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 40,
                            ),
                            onPressed: () {
                              taskVm.deleteTask(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.03,
                    ),
                    const Text(
                      "Add Task",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.03,
                    ),
                    SizedBox(
                      width: deviceWidth * 0.8,
                      height: deviceWidth * 0.13,
                      child: TextField(
                        maxLines: 1,
                        minLines: 1,
                        controller: titleController,
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          icon: Icon(Icons.title, color: const Color(0xFF1CAAC9), size: deviceWidth * 0.06),
                          hintText: "task title",
                          hintStyle: TextStyle(
                            fontSize: deviceWidth * 0.03,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(deviceWidth * 0.03),
                            gapPadding: 0,
                          ),
                          fillColor: Colors.white,
                          errorMaxLines: 1,
                          isDense: true,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(deviceWidth * 0.03),
                            gapPadding: 0,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(deviceWidth * 0.03),
                            gapPadding: 0,
                            borderSide: const BorderSide(color: Colors.transparent),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: deviceWidth * 0.03,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        textAlignVertical: TextAlignVertical.bottom,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.03,
                    ),
                    SizedBox(
                      width: deviceWidth * 0.8,
                      height: deviceWidth * 0.13,
                      child: TextField(
                        maxLines: 1,
                        minLines: 1,
                        autofocus: false,
                        controller: descriptionController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          icon: Icon(Icons.description, color: const Color(0xFF1CAAC9), size: deviceWidth * 0.06),
                          hintText: "task title",
                          hintStyle: TextStyle(
                            fontSize: deviceWidth * 0.03,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(deviceWidth * 0.03),
                            gapPadding: 0,
                          ),
                          fillColor: Colors.white,
                          errorMaxLines: 1,
                          isDense: true,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(deviceWidth * 0.03),
                            gapPadding: 0,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(deviceWidth * 0.03),
                            gapPadding: 0,
                            borderSide: const BorderSide(color: Colors.transparent),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: deviceWidth * 0.03,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        textAlignVertical: TextAlignVertical.bottom,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.03,
                    ),
                    SizedBox(
                      width: deviceWidth * 0.8,
                      height: deviceWidth * 0.13,
                      child: TextField(
                        maxLines: 1,
                        minLines: 1,
                        autofocus: false,
                        controller: dateController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          icon: Icon(Icons.date_range, color: const Color(0xFF1CAAC9), size: deviceWidth * 0.06),
                          hintText: "task title",
                          hintStyle: TextStyle(
                            fontSize: deviceWidth * 0.03,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(deviceWidth * 0.03),
                            gapPadding: 0,
                          ),
                          fillColor: Colors.white,
                          errorMaxLines: 1,
                          isDense: true,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(deviceWidth * 0.03),
                            gapPadding: 0,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(deviceWidth * 0.03),
                            gapPadding: 0,
                            borderSide: const BorderSide(color: Colors.transparent),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: deviceWidth * 0.03,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        textAlignVertical: TextAlignVertical.bottom,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (titleController.text != "" ||
                            descriptionController.text != "" ||
                            dateController.text != "") {
                          context
                              .read<TaskViewModel>()
                              .addTask(titleController.text, descriptionController.text, dateController.text);
                          Navigator.pop(context);
                        }
                      },
                      child: Center(
                        child: Container(
                          height: deviceHeight * 0.05,
                          width: deviceWidth * 0.6,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1CAAC9),
                            borderRadius: BorderRadius.all(
                              Radius.circular(deviceWidth * 0.03),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'add ',
                              style: TextStyle(color: Colors.white, fontSize: deviceWidth * 0.06),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
