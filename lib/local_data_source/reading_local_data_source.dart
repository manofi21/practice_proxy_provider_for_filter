import 'package:proxy_provider_for_filter/model/read_status_model_v1.dart';

import '../model/read_type_model_v1.dart';
import '../model/reading_model_v1.dart';
import '../sql_db/sql_repo.dart';
import '../repository/convert_maps_to_entity.dart' show keyidtable;

abstract class ReadingLocalDataSource {
  Future<List<ReadTypeModelV1>> getListReadTypeModel();
  Future<List<ReadStatusModelV1>> getListReadStatusModel();
  Future<List<Map<String, dynamic>>> getListReadingHistory({
    String whereQuery = '',
    List<Object?> whereArgument = const [],
  });
  Future<void> addReadingHistory(ReadingModelV1 readingEntity);
  Future<void> updateReadingHistory(ReadingModelV1 readingEntity);
}

class ReadingLocalDataSourceImpl implements ReadingLocalDataSource {
  @override
  Future<List<Map<String, dynamic>>> getListReadingHistory({
    String whereQuery = '',
    List<Object?> whereArgument = const [],
  }) async {
    final sqlBase = SqlBaseRepoImpl();

    final resultFromQuery = await sqlBase.getListDataRawQuery(
      fromMap: (e) => e,
      rawQuery:
          "SELECT ${ReadingModelV1.table}.${ReadingModelV1.keyid} as $keyidtable,* FROM ${ReadingModelV1.table} "
          "INNER JOIN ${ReadTypeModelV1.table} ON ${ReadingModelV1.table}.${ReadingModelV1.keyidtype} = ${ReadTypeModelV1.table}.${ReadTypeModelV1.keyid} "
          "INNER JOIN ${ReadStatusModelV1.table} ON ${ReadingModelV1.table}.${ReadingModelV1.keyidstatus} = ${ReadStatusModelV1.table}.${ReadStatusModelV1.keyid}"
          "$whereQuery",
      arguments: whereArgument,
    );
    return resultFromQuery;
  }

  @override
  Future<void> addReadingHistory(ReadingModelV1 readingEntity) async {
    final sqlBase = SqlBaseRepoImpl();
    await sqlBase.insertData(ReadingModelV1.table, readingEntity.toMap());
  }

  @override
  Future<void> updateReadingHistory(ReadingModelV1 readingEntity) async {
    final sqlBase = SqlBaseRepoImpl();
    await sqlBase.updateData(
      ReadingModelV1.table,
      readingEntity.toUpdateMap(),
      where: "${ReadingModelV1.keyid} = ?",
      whereArgs: [readingEntity.id],
    );
  }

  @override
  Future<List<ReadStatusModelV1>> getListReadStatusModel() {
    final sqlBase = SqlBaseRepoImpl();
    return sqlBase.getListData(
        table: ReadStatusModelV1.table, fromMap: ReadStatusModelV1.fromMap);
  }

  @override
  Future<List<ReadTypeModelV1>> getListReadTypeModel() {
    final sqlBase = SqlBaseRepoImpl();
    return sqlBase.getListData(
        table: ReadTypeModelV1.table, fromMap: ReadTypeModelV1.fromMap);
  }
}
