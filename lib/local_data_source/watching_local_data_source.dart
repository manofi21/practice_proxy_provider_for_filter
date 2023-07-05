import 'package:proxy_provider_for_filter/model/watch_status_model_v1.dart';

import '../model/watch_type_model_v1.dart';
import '../model/watching_model_v1.dart';
import '../sql_db/sql_repo.dart';
import '../repository/convert_maps_to_entity.dart' show keyidtable;

abstract class WatchingLocalDataSource {
  Future<List<WatchTypeModelV1>> getListWatchTypeModel();
  Future<List<WatchStatusModelV1>> getListWatcStatusModel();
  Future<List<Map<String, dynamic>>> getListWatchingHistory({
    String? whereQuery,
    List<Object?> whereArgument = const [],
  });
  Future<void> addWatchingHistory(WatchingModelV1 watchingEntity);
  Future<void> updateWatchingHistory(WatchingModelV1 watchingEntity);
}

class WatchingLocalDataSourceImpl implements WatchingLocalDataSource {
  @override
  Future<List<Map<String, dynamic>>> getListWatchingHistory({
    String? whereQuery,
    List<Object?> whereArgument = const [],
  }) async {
    final sqlBase = SqlBaseRepoImpl();
    final resultFromQuery = await sqlBase.getListDataRawQuery(
      fromMap: (e) => e,
      rawQuery:
          "SELECT ${WatchingModelV1.table}.${WatchingModelV1.keyid} as $keyidtable,* FROM ${WatchingModelV1.table} "
          "INNER JOIN ${WatchTypeModelV1.table} ON ${WatchingModelV1.table}.${WatchingModelV1.keyidtype} = ${WatchTypeModelV1.table}.${WatchTypeModelV1.keyid} "
          "INNER JOIN ${WatchStatusModelV1.table} ON ${WatchingModelV1.table}.${WatchingModelV1.keyidstatus} = ${WatchStatusModelV1.table}.${WatchStatusModelV1.keyid}"
          "$whereQuery",
      arguments: whereArgument,
    );

    return resultFromQuery;
  }

  @override
  Future<void> addWatchingHistory(WatchingModelV1 watchingEntity) async {
    final sqlBase = SqlBaseRepoImpl();
    await sqlBase.insertData(WatchingModelV1.table, watchingEntity.toMap());
  }

  @override
  Future<void> updateWatchingHistory(WatchingModelV1 watchingEntity) async {
    final sqlBase = SqlBaseRepoImpl();
    await sqlBase.updateData(
      WatchingModelV1.table,
      watchingEntity.toUpdateMap(),
      where: "${WatchingModelV1.keyid} = ?",
      whereArgs: [watchingEntity.id],
    );
  }

  @override
  Future<List<WatchTypeModelV1>> getListWatchTypeModel() {
    final sqlBase = SqlBaseRepoImpl();
    return sqlBase.getListData(
        table: WatchTypeModelV1.table, fromMap: WatchTypeModelV1.fromMap);
  }

  @override
  Future<List<WatchStatusModelV1>> getListWatcStatusModel() {
    final sqlBase = SqlBaseRepoImpl();
    return sqlBase.getListData(
        table: WatchStatusModelV1.table, fromMap: WatchStatusModelV1.fromMap);
  }
}
