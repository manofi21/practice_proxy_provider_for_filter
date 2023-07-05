import 'package:proxy_provider_for_filter/model/game_status_model_v1.dart';

import '../model/game_type_model_v1.dart';
import '../model/gaming_model_v1.dart';
import '../sql_db/sql_repo.dart';
import '../repository/convert_maps_to_entity.dart'
    show keyidtable;

abstract class GamingLocalDataSource {
  Future<List<GameTypeModelV1>> getListGameTypeModel();
  Future<List<GameStatusModelV1>> getListGameStatusModel();
  Future<List<Map<String, dynamic>>> getListGamingHistory({
    String? whereQuery,
    List<Object?> whereArgument = const [],
  });
  Future<void> addGamingHistory(GamingModelV1 gamingEntity);
  Future<void> updateGamingHistory(GamingModelV1 gamingEntity);
}

class GamingLocalDataSourceImpl implements GamingLocalDataSource {
  @override
  Future<List<Map<String, dynamic>>> getListGamingHistory({
    String? whereQuery,
    List<Object?> whereArgument = const [],
  }) async {
    final sqlBase = SqlBaseRepoImpl();

    final resultFromQuery = await sqlBase.getListDataRawQuery(
      fromMap: (e) => e,
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
