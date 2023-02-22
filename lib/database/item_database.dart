import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task_model.dart';

class SQLHelper {

  SQLHelper._instance();
  static final SQLHelper instance = SQLHelper._instance();

  static Database? _db = null;


  //it will check database is empty or not. If empty it create a database otherwise it will returns existing database
  Future<Database?> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  //this method we used for initialize our database
  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'todoList.db';
    final todoListDB =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return todoListDB;
  }

  //this method we used for create our database
  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE taskTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        status INTEGER
      )
    ''');
  }
}
