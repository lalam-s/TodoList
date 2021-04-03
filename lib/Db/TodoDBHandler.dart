import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:async';
import 'Todo.dart';

class TodoDBHandler {
  final databaseName = "todos.db";
  final tableName = "todos";
  final fieldMap = {
    "id": "INTEGER PRIMARY KEY AUTOINCREMENT",
    "title": "BLOB",
    "content": "BLOB",
    "iscompleted": "INTEGER"
  };
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var path = await getDatabasesPath();
    var dbPath = join(path, 'todos.db');
    Database dbConnection = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
      print("executing create query from onCreate callback");
      await db.execute(_buildCreateQuery());
    });
    await dbConnection.execute(_buildCreateQuery());
    _buildCreateQuery();
    return dbConnection;
  }

  String _buildCreateQuery() {
    String query = "CREATE TABLE IF NOT EXISTS ";
    query += tableName;
    query += "(";
    fieldMap.forEach((column, field) {
      print("$column:$field");
      query += "$column $field,";
    });
    query = query.substring(0, query.length - 1);
    query += " )";
    return query;
  }

  static Future<String> dbPath() async {
    String path = await getDatabasesPath();
    return path;
  }

  Future<int> insertTodo(Todo todo, bool isNew) async {
    final Database db = await database;
    print("insert called");
    await db.insert(
      'todos',
      isNew ? todo.toMap(false) : todo.toMap(true),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    if (isNew) {
      var one = await db.query('todos',
          orderBy: "id desc", where: "iscompleted=?", whereArgs: [0], limit: 1);
      int latestId = one.first["id"] as int;
      return latestId;
    }
    return todo.id;
  }

  Future<bool> update(int id, int complete) async {
    final Database db = await database;
    if (id != -1) {
      var updateid = id;
      await db.rawUpdate('''UPDATE todos SET iscompleted = ? WHERE id =?''',
          [complete, updateid]);
      return true;
    }
    return false;
  }

  Future<bool> delete(int id) async {
    final Database db = await database;
    try {
      if (id == -2) {
        await db.delete("todos", where: "iscomplete=?", whereArgs: [1]);
      } else {
        await db.delete("todos", where: "id=?", whereArgs: [id]);
      }
      return true;
    } catch (Error) {
      print("Error deleting id=${id} :${Error.toString()}");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> selectAllTodos(int iscomplete) async {
    final Database db = await database;
    var data = db.query("todos",
        orderBy: "id desc", where: "iscompleted=?", whereArgs: [iscomplete]);
    return data;
  }
}
