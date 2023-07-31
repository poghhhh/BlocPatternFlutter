import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/tasks.dart';

class TaskDatabase {
  static const String tableName = 'tasks';
  static const String columnId = 'id';
  static const String columnTitle = 'title';
  static const String columnIsDone = 'isDone';
  static const String columnIsDelete = 'isDelete';

  Future<Database> initDatabase() async {
    // await deleteAllDatabases();

    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'tasks_database.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableName (
        $columnId TEXT PRIMARY KEY,
        $columnTitle TEXT NOT NULL,
        $columnIsDone INTEGER ,
        $columnIsDelete INTEGER 
      )
    ''');
  }

  Future<void> deleteAllDatabases() async {
    final databasesPath = await getDatabasesPath();
    final databasesDirectory = Directory(databasesPath);
    final databases = await databasesDirectory.list().toList();

    for (var database in databases) {
      if (database is File && database.path.endsWith('.db')) {
        await database.delete();
      }
    }
  }

  Future<List<Task>> getAllTasks() async {
    final db = await initDatabase();
    final tasksMapList = await db.query(tableName);
    return tasksMapList.map((taskMap) => Task.fromMap(taskMap)).toList();
  }

  Future<Task> insertTask(Task task) async {
    final db = await initDatabase();
    await db.insert(tableName, task.toMap());
    return task;
  }

  Future<void> updateTask(Task task) async {
    final db = await initDatabase();
    await db.update(
      tableName,
      task.toMap(),
      where: '$columnId = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(Task task) async {
    final db = await initDatabase();
    await db.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [task.id],
    );
  }
}
