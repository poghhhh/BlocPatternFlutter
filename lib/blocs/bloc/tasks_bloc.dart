import 'package:bloc_pattern/models/tasks.dart';
import 'package:bloc_pattern/services/BoolConvert.dart';
import 'package:equatable/equatable.dart';

import '../../Database/tasks.dart';
import '../bloc_export.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TaskDatabase _taskDatabase = TaskDatabase();

  TasksBloc() : super(TasksState()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTaskk);
    on<DeleteTask>(_onDeleteTask);
  }

  void _onLoadTasks(LoadTasks event, Emitter<TasksState> emit) async {
    final tasks = await _taskDatabase.getAllTasks();
    emit(TasksState(allTasks: tasks));
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) async {
    await _taskDatabase.insertTask(event.task);
    emit(TasksState(allTasks: List.from(state.allTasks)..add(event.task)));
  }

  void _onUpdateTaskk(UpdateTask event, Emitter<TasksState> emit) async {
    final task = event.task;
    final updatedTask =
        task.copyWith(isDone: boolToInt(intToBool(task.isDone ?? 0)));

    await _taskDatabase.updateTask(updatedTask);

    final updatedTasks =
        state.allTasks.map((t) => t.id == task.id ? updatedTask : t).toList();
    emit(TasksState(allTasks: updatedTasks));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) async {
    await _taskDatabase.deleteTask(event.task);
    emit(TasksState(allTasks: List.from(state.allTasks)..remove(event.task)));
  }
}
