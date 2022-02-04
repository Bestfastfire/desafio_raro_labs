import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBControl{
  static Database? _database;

  static Future<Database> get _db async =>
      _database ??= await _init();

  static _init() async {
    const _dbName = kReleaseMode ? 'release' : 'dev';

    final _path = join(await getDatabasesPath(), '$_dbName.db');

    return await openDatabase(_path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE users ('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'name TEXT, '
              'parking_size INTEGER) ');

          await db.execute('CREATE TABLE parking_history ('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'id_user INTEGER, '
              'parking INTEGER, '
              'type TEXT, '
              'datetime TEXT)');
        });
  }

  static Future<bool> hasUser() async{
    final db = await _db;

    final _select = await db
        .rawQuery('SELECT * FROM users');

    return _select.isNotEmpty;
  }
}