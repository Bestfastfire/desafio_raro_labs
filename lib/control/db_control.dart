import 'package:desafio_raro_labs/tools/extensions/date_time_extension.dart';
import 'package:desafio_raro_labs/tools/extensions/string_extension.dart';
import 'package:desafio_raro_labs/model/parking_history_model.dart';
import 'package:desafio_raro_labs/model/parking_model.dart';
import 'package:desafio_raro_labs/model/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBControl{
  static String version = 'v1';
  static Database? _database;

  static Future<Database> get _db async =>
      _database ??= await _init();

  static _init() async {
    final _dbName = kReleaseMode
        ? 'release_$version'
        : 'dev_$version';

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
              'datetime TEXT,'
              'milliseconds INTEGER)');
        });
  }

  static Future<bool> hasUser() async{
    return await getCurrentUser() != null;
  }

  static Future registerUser({
    required String userName,
    required int parkingSize
  }) async{
    final db = await _db;

    await db.rawInsert('INSERT INTO users (name, parking_size) '
        'VALUES (?, ?)', [userName, parkingSize]);
  }

  static Future<UserModel?> getCurrentUser() async{
    final db = await _db;

    final _select = await db
        .rawQuery('SELECT id, name, parking_size FROM users '
        'ORDER BY id DESC LIMIT 1');

    if(_select.isNotEmpty){
      return UserModel(_select[0]);

    }

    return null;
  }

  static Future<int> getParkingSize() async{
    final db = await _db;

    final user = await db.rawQuery(
        'SELECT * FROM users ORDER BY id DESC LIMIT 1');

    return user[0]['parking_size'].toString().asInt;
  }

  static Future<ParkingHistoryModel> getLastHistoryParking(int parkingNumber) async{
    final db = await _db;

    final _history = await db.rawQuery(
        'SELECT parking, type, datetime FROM parking_history WHERE '
            'parking = ? ORDER BY id DESC LIMIT 1', [parkingNumber]);


    if(_history.isEmpty){
      return ParkingHistoryModel.empty(parkingNumber);

    }

    return ParkingHistoryModel(_history[0]);
  }

  static Future<List<ParkingModel>> getParkingList() async{
    final _size = await getParkingSize();
    final _list = <ParkingModel>[];

    for(int i = 0; i < _size; i++){
      final _history = await getLastHistoryParking(i);
      _list.add(ParkingModel(
          isOccupied: _history.isOccupied,
          number: i));

    }

    return _list;
  }

  static Future putHistory(int number, String type, DateTime date) async{
    final db = await _db;

    final user = await getCurrentUser();
    if(user != null){
      await db.rawInsert('INSERT INTO parking_history '
          '(id_user, parking, type, datetime, milliseconds) VALUES (?, ?, ?, ?, ?)', [
            user.id,
            number,
            type,
            date.dbFormatted,
            date.millisecondsSinceEpoch
          ]);
    }
  }

  static Future<List<ParkingHistoryModel>> getParkingHistory(int milliSecondsStart, int milliSecondsEnd) async{
    final user = await getCurrentUser();
    final db = await _db;

    if(user != null){
      final _select = await db.rawQuery('SELECT * FROM parking_history '
          'WHERE id_user = ? AND milliseconds >= ? AND milliseconds <= ? '
          'ORDER BY milliseconds DESC', [user.id,
        milliSecondsStart, milliSecondsEnd]);

      return _select.map((item) => ParkingHistoryModel(
          item)).toList();
    }

    return [];
  }

  static updateParkingSize(int size, int id) async{
    final db = await _db;
    await db.rawUpdate(
        'UPDATE users SET parking_size = ? WHERE id = ?', [size, id]);
  }
}