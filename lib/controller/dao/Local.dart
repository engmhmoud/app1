import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';

class Local {
  static Database _db;
  final String userTable = 'userTable';
  final String columnUserName = 'username';
  final String columnPassword = 'password';
  final String columnId = 'id';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await intDB();
    return _db;
  }

  intDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'myFriends.db');
    var myOwnDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return myOwnDB;
  }

  void _onCreate(Database db, int newVersion) async {
    var sql = "CREATE TABLE    $userTable ($columnId TEXT PRIMARY KEY,"
        " $columnUserName TEXT, $columnPassword TEXT    )";
    await db.execute(sql);
  }

  Future<int> saveUser({String id, String username, String pass}) async {
     
    var dbClient = await db;
    int result = await dbClient.insert("$userTable", {
      columnUserName: username,
      columnId: id,
      columnPassword: pass
    }).then((onValue) {
      print("DONE");
    });

    return result;
  }

  Future<List> getAllUsers() async {
    var dbClient = await db;
    var sql = "SELECT * FROM $userTable";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<Map<String, dynamic>> getUser(int id) async {
    var dbClient = await db;
    var sql = "SELECT * FROM $userTable WHERE $columnId = $id";
    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;
    return (result.first);
  }

  Future<int> deleteUser(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(userTable, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<void> close() async {
    var dbClient = await db;
    return await dbClient.close();
  }
}
