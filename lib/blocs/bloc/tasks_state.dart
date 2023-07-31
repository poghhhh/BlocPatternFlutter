part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> allTasks;

  TasksState({
    this.allTasks = const <Task>[],
  });

  @override
  List<Object?> get props => [allTasks];
}
