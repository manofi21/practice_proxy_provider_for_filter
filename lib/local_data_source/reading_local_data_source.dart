import 'package:proxy_provider_for_filter/model/read_status_model_v1.dart';

import '../entities/reading_model_entity.dart';
import '../model/filter_model/filter_history_model.dart';
import '../model/read_type_model_v1.dart';
import '../model/reading_model_v1.dart';
import '../sql_db/sql_repo.dart';
import '../utils/convert_maps_to_entity.dart'
    show convertMapToReadingEntitiy, keyidtable;

abstract class ReadingLocalDataSource {
  Future<List<ReadTypeModelV1>> getListReadTypeModel();
  Future<List<ReadStatusModelV1>> getListReadStatusModel();
  Future<List<ReadingModelEntity>> getListReadingHistory(
      {FilterHistoryModel? filterHistoryModel});
  Future<void> addReadingHistory(ReadingModelV1 readingEntity);
  Future<void> updateReadingHistory(ReadingModelV1 readingEntity);
}

class ReadingLocalDataSourceImpl implements ReadingLocalDataSource {
  @override
  Future<List<ReadingModelEntity>> getListReadingHistory(
      {FilterHistoryModel? filterHistoryModel}) async {
    final sqlBase = SqlBaseRepoImpl();
    final filterModel = filterHistoryModel?.toStringFilterQUery(
      ReadingModelV1.table,
      columnStatusId: ReadingModelV1.keyidstatus,
      columnFavorite: ReadingModelV1.keyfavorite,
      columnTypeId: ReadingModelV1.keyidtype,
    );

    final whereQuery = filterModel?.whereQuery ?? '';
    final whereArgument = filterModel?.argument ?? [];

    final resultFromQuery =
        await sqlBase.getListDataRawQuery<ReadingModelEntity>(
      fromMap: convertMapToReadingEntitiy,
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
