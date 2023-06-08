import 'package:proxy_provider_for_filter/model/watch_status_model_v1.dart';

import '../entities/watching_model_entity.dart';
import '../model/watch_type_model_v1.dart';
import '../model/watching_model_v1.dart';
import '../sql_db/sql_repo.dart';
import '../utils/convert_maps_to_entity.dart' show convertMapToWatchingEntitiy, keyidtable;

abstract class WatchingRepo {
  Future<List<WatchTypeModelV1>> getListWatcTypeModel();
  Future<List<WatchStatusModelV1>> getListWatcStatusModel();
  Future<List<WatchingModelEntity>> getListWatchingHistory();
  Future<void> addWatchingHistory(WatchingModelV1 watchingEntity);
  Future<void> updateWatchingHistory(WatchingModelV1 watchingEntity);
}

class WatchingRepoImpl implements WatchingRepo {
  @override
  Future<List<WatchingModelEntity>> getListWatchingHistory() async {
    final sqlBase = SqlBaseRepoImpl();
    final resultFromQuery = await sqlBase.getListDataRawQuery<WatchingModelEntity>(
      fromMap: convertMapToWatchingEntitiy,
      rawQuery: "SELECT ${WatchingModelV1.table}.${WatchingModelV1.keyid} as $keyidtable,* FROM ${WatchingModelV1.table} "
          "INNER JOIN ${WatchTypeModelV1.table} ON ${WatchingModelV1.table}.${WatchingModelV1.keyidtype} = ${WatchTypeModelV1.table}.${WatchTypeModelV1.keyid} "
          "INNER JOIN ${WatchStatusModelV1.table} ON ${WatchingModelV1.table}.${WatchingModelV1.keyidstatus} = ${WatchStatusModelV1.table}.${WatchStatusModelV1.keyid}",
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
    await sqlBase.insertData(WatchingModelV1.table, watchingEntity.toMap());
  }
  
  @override
  Future<List<WatchTypeModelV1>> getListWatcTypeModel() {
    final sqlBase = SqlBaseRepoImpl();
    return sqlBase.getListData(table: WatchTypeModelV1.table, fromMap: WatchTypeModelV1.fromMap);
  }

  @override
  Future<List<WatchStatusModelV1>> getListWatcStatusModel() {
    final sqlBase = SqlBaseRepoImpl();
    return sqlBase.getListData(table: WatchStatusModelV1.table, fromMap: WatchStatusModelV1.fromMap);
  }
}
