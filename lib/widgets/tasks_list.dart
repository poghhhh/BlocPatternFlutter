import 'package:bloc_pattern/blocs/bloc_export.dart';
import 'package:bloc_pattern/services/BoolConvert.dart';
import 'package:flutter/material.dart';

import '../models/tasks.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.taskList,
  });

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          var task = taskList[index];
          return ListTile(
            title: Text(task.title),
            trailing: Checkbox(
              value: task.isDone,
              onChanged: (value) {
                context.read<TasksBloc>().add(UpdateTask(task: task));
              },
            ),
            onLongPress: () {
              _showAlertDialog(
                  context, task); // Call the function to show the dialog
            },
          );
        },
      ),
    );
  }
}

void _showAlertDialog(BuildContext context, Task task) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Wanna Delete ?'),
        content: Text('Do you want to delete task "${task.title}"?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
              context.read<TasksBloc>().add(DeleteTask(task: task));
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
