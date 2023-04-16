import 'package:flutter/material.dart';
import 'package:sqlite_todolist/database/sqlite_crud.dart';
import 'package:sqlite_todolist/models/task_model.dart';

class TaskProvider with ChangeNotifier{
  List<TaskModel> _task = [];

  List<TaskModel> get task => _task;

  final _taskToDo=TaskToDo();

  void addTask(TaskModel taskModel) async{
    await _taskToDo.insertTask(taskModel);
    _task = await _taskToDo.getTaskList();
    notifyListeners();
  }


  void getTasks() async {
    _task = await _taskToDo.getTaskList();
    notifyListeners();
  }

  void updateTask(TaskModel taskModel) async{
    await _taskToDo.updateTask(taskModel);
    _task= await _taskToDo.getTaskList();
    notifyListeners();
  }

  void deleteTask(int id) async {
    await _taskToDo.deleteTask(id);
    _task = await _taskToDo.getTaskList();
    notifyListeners();
  }

}