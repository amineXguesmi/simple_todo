import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop4/core/viewModels/task_viewModel.dart';
import 'package:workshop4/ui/screens/task_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => TaskViewModel(),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: TaskScreen(),
        )),
  );
}
