import 'package:sqflite/sqflite.dart';
import 'package:sqlite_todolist/database/item_database.dart';
import '../models/task_model.dart';

class TaskToDo{
  final dbProvider=SQLHelper.instance;

  //this method we used for insert data in our database
  Future<int> insertTask(TaskModel taskModel) async {
    Database? db = await dbProvider.db;
    final int result = await db!.insert('taskTable', taskModel.toMap());
    return result;
  }

  Future<List<TaskModel>> getTaskList() async {
    final db = await dbProvider.db;
    final List<Map<String, dynamic>> maps = await db!.query('taskTable');
    return List.generate(maps.length, (i) => TaskModel.fromMap(maps[i]));
  }

  //this method we used for update data in our database
  Future<int> updateTask(TaskModel taskModel) async {
    Database? db = await dbProvider.db;
    final int result = await db!.update('taskTable', taskModel.toMap(),
        where: "id = ?", whereArgs: [taskModel.id]);
    return result;
  }//real device e run koren

  //this method we used for delete data in our database
  Future<int> deleteTask(int id) async {
    Database? db = await dbProvider.db;
    final int result =
    await db!.delete('taskTable', where: "id = ?", whereArgs: [id]);
    return result;
  }
}