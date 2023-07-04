import 'package:proxy_provider_for_filter/model/game_status_model_v1.dart';

import '../entities/gaming_model_entity.dart';
import '../model/filter_model/filter_history_model.dart';
import '../model/game_type_model_v1.dart';
import '../model/gaming_model_v1.dart';
import '../sql_db/sql_repo.dart';
import '../utils/convert_maps_to_entity.dart'
    show convertMapToGamingEntitiy, keyidtable;

abstract class GamingLocalDataSource {
  Future<List<GameTypeModelV1>> getListGameTypeModel();
  Future<List<GameStatusModelV1>> getListGameStatusModel();
  Future<List<GamingModelEntity>> getListGamingHistory(
      {FilterHistoryModel? filterHistoryModel});
  Future<void> addGamingHistory(GamingModelV1 gamingEntity);
  Future<void> updateGamingHistory(GamingModelV1 gamingEntity);
}

class GamingLocalDataSourceImpl implements GamingLocalDataSource {
  @override
  Future<List<GamingModelEntity>> getListGamingHistory(
      {FilterHistoryModel? filterHistoryModel}) async {
    final sqlBase = SqlBaseRepoImpl();
    final filterModel = filterHistoryModel?.toStringFilterQUery(
      GamingModelV1.table,
      columnStatusId: GamingModelV1.keyidstatus,
      columnFavorite: GamingModelV1.keyfavorite,
      columnTypeId: GamingModelV1.keyidtype,
    );
    final whereQuery = filterModel?.whereQuery ?? '';
    final whereArgument = filterModel?.argument ?? [];

    final resultFromQuery =
        await sqlBase.getListDataRawQuery<GamingModelEntity>(
      fromMap: convertMapToGamingEntitiy,
      rawQuery:
          "SELECT ${GamingModelV1.table}.${GamingModelV1.keyid} as $keyidtable,* FROM ${GamingModelV1.table} "
          "INNER JOIN ${GameTypeModelV1.table} ON ${GamingModelV1.table}.${GamingModelV1.keyidtype} = ${GameTypeModelV1.table}.${GameTypeModelV1.keyid} "
          "INNER JOIN ${GameStatusModelV1.table} ON ${GamingModelV1.table}.${GamingModelV1.keyidstatus} = ${GameStatusModelV1.table}.${GameStatusModelV1.keyid}"
          "$whereQuery",
      arguments: whereArgument,
    );

    return resultFromQuery;
  }

  @override
  Future<void> addGamingHistory(GamingModelV1 gamingEntity) async {
    final sqlBase = SqlBaseRepoImpl();
    await sqlBase.insertData(GamingModelV1.table, gamingEntity.toMap());
  }

  @override
  Future<void> updateGamingHistory(GamingModelV1 gamingEntity) async {
    final sqlBase = SqlBaseRepoImpl();
    await sqlBase.updateData(
      GamingModelV1.table,
      gamingEntity.toUpdateMap(),
      where: "${GamingModelV1.keyid} = ?",
      whereArgs: [gamingEntity.id],
    );
  }

  @override
  Future<List<GameStatusModelV1>> getListGameStatusModel() {
    final sqlBase = SqlBaseRepoImpl();
    return sqlBase.getListData(
        table: GameStatusModelV1.table, fromMap: GameStatusModelV1.fromMap);
  }

  @override
  Future<List<GameTypeModelV1>> getListGameTypeModel() {
    final sqlBase = SqlBaseRepoImpl();
    return sqlBase.getListData(
        table: GameTypeModelV1.table, fromMap: GameTypeModelV1.fromMap);
  }
}
