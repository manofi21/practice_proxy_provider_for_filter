import 'dart:async';

import 'package:proxy_provider_for_filter/sql_db/setup_db.dart';
import 'package:sqflite/sqflite.dart';

import '../utils/convert_type.dart';
import 'sqflite_order.dart';

abstract class SqlBaseRepo {
  Future<void> insertData(String table, Map<String, Object?> mapData);
  Future<void> updateData(
    String table,
    Map<String, Object?> mapData, {
    String? where,
    List<Object?>? whereArgs,
  });
  Future<List<T>> getListData<T>({
    required String table,
    required T Function(Map<String, dynamic> map) fromMap,
  });
  Future<List<T>> getListDataRawQuery<T>({
    required String rawQuery,
    required T Function(Map<String, dynamic> map) fromMap,
  });
  Future<T?> getSingleData<T>({
    required String table,
    required T Function(Map<String, dynamic> map) fromMap,
    String? where,
    List<Object?>? whereArgs,
  });
  Future<void> deleteData({
    required String table,
    String? where,
    List<Object?>? whereArgs,
  });
  Future<T> doBatchActionValue<T>({
    required FutureOr<void> Function(Batch batch) action,
    required FutureOr<T> Function(List<Object?> valueResult) handleResut,
  });
}

class SqlBaseRepoImpl implements SqlBaseRepo {
  static final SqlBaseRepoImpl _instance =
      SqlBaseRepoImpl._privateConstructor();
  static Database? _database;

  SqlBaseRepoImpl._privateConstructor();

  factory SqlBaseRepoImpl() {
    return _instance;
  }

  Future<Database> get database async {
    final currDatabase = _database;
    if (currDatabase != null) {
      return currDatabase;
    }

    // Jika _database null, maka inisialisasi database
    _database = await getAndSetupDB();
    return _database!;
  }

  @override
  Future<void> deleteData({
    required String table,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final db = await database;
    await db.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  @override
  Future<List<T>> getListData<T>({
    required String table,
    required T Function(Map<String, dynamic> map) fromMap,
    int? limit,
    SqfliteOrder? orderBy,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final db = await database;
    final listDBData = await db.query(
      table,
      limit: limit,
      orderBy: orderBy?.value,
      where: where,
      whereArgs: whereArgs,
    );

    final listData = listDBData.map((map) => fromMap(map)).toList();
    return listData;
  }

  @override
  Future<T?> getSingleData<T>({
    required String table,
    required T Function(Map<String, dynamic> map) fromMap,
    String? where,
    List<Object?>? whereArgs,
    SqfliteOrder? orderBy,
  }) async {
    final db = await database;
    final listDBData = await db.query(
      table,
      orderBy: orderBy?.value,
      where: where,
      whereArgs: whereArgs,
    );
    final listData = listDBData.map((map) => fromMap(map)).toList();
    if (listData.isEmpty) {
      return null;
    }
    return listData.first;
  }

  @override
  Future<void> insertData(
    String table,
    Map<String, Object?> mapData,
  ) async {
    final db = await database;
    await db.insert(table, mapData);
  }

  @override
  Future<T> doBatchActionValue<T>({
    required FutureOr<void> Function(Batch batch) action,
    required FutureOr<T> Function(List<Object?> valueResult) handleResut,
  }) async {
    final db = await database;
    final asBatch = db.batch();
    await action(asBatch);

    final result = await asBatch.commit();
    final handledResult = await handleResut(result);
    return handledResult;
  }

  Future<int> countDataFromTable(
    String tableName, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final db = await database;

    final tableWithWhere =
        tableName + ((where ?? '').isEmpty ? '' : ' WHERE $where');
    final countData = await db.rawQuery(
      'SELECT COUNT(*) FROM $tableWithWhere',
      whereArgs,
    );
    final returnValue = countData.isEmpty
        ? -1
        : (countData.first.values.isEmpty
            ? -1
            : convertType<int>(countData.first.values.first) ?? 0);
    return returnValue;
  }

  @override
  Future<List<T>> getListDataRawQuery<T>({
    required String rawQuery,
    required T Function(Map<String, dynamic> map) fromMap,
    List<Object?>? arguments = const [],
  }) async {
    final db = await database;
    final resultRawQuery = await db.rawQuery(rawQuery, arguments);
    return resultRawQuery.map((e) => fromMap(e)).toList();
  }

  @override
  Future<void> updateData(
    String table,
    Map<String, Object?> mapData, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final db = await database;
    await db.update(table, mapData, where: where, whereArgs: whereArgs);
  }
}

/* 
  Future<int> insert(String table, Map<String, dynamic> data) async {
    // Memasukkan data ke dalam tabel pada database
    final db = await database;
    return await db.insert(table, data);
  }

  Future<int> update(String table, Map<String, dynamic> data, int id) async {
    // Mengubah data pada tabel pada database berdasarkan id
    final db = await database;
    return await db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(String table, int id) async {
    // Menghapus data pada tabel pada database berdasarkan id
    final db = await database;
    return await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> query(String table) async {
    // Mengambil semua data dari tabel pada database
    final db = await database;
    return await db.query(table);
  }
*/