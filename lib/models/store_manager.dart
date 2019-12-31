import 'package:sqflite/sqflite.dart';
import 'package:todoey_flutter/models/task.dart';
import 'package:path/path.dart';

class StoreManager {
  Database db;

  String tableName = 'todoey';
  String columnId = 'tid';
  String columnTitle = 'name';
  String columnIsDone = 'isDone';

//  StoreManager() {
//    open();
//  }

  Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todoey.db');

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'create table $tableName ($columnId integer primary key autoincrement, $columnTitle text not null, $columnIsDone bool not null)');
    });
  }

  Future<Task> insert(Task task) async {
    task.tid = await db.insert(tableName, task.toMap());
    return task;
  }

  Future<Task> getTask(int tid) async {
    List<Map> maps = await db.query(tableName,
        columns: [columnId, columnIsDone, columnTitle],
        where: '$columnId = ?',
        whereArgs: [tid]);
    if (maps.length > 0) {
      return Task.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Task>> getTasks() async {
    List<Map> maps = await db
        .query(tableName, columns: [columnId, columnIsDone, columnTitle]);
    if (maps.length > 0) {
      List<Task> tasks = [];
      for (var map in maps) {
        tasks.add(Task.fromMap(map));
      }
      return tasks;
    }
    return null;
  }

  Future<int> delete(int tid) async {
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [tid]);
  }

  Future<int> update(Task task) async {
    return await db.update(tableName, task.toMap(),
        where: '$columnId = ?', whereArgs: [task.tid]);
  }

  Future close() async => db.close();
}
