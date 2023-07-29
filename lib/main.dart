import 'package:bloc_pattern/models/tasks.dart';
import 'package:bloc_pattern/screen/Task/tasks_screen.dart';

import 'package:flutter/material.dart';
import 'blocs/bloc_export.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksBloc()
        ..add(AddTask(
          task: Task(title: 'Task 1 '),
        )),
      child: MaterialApp(
        title: 'Flutter Tasks App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TasksScreen(),
      ),
    );
  }
}
