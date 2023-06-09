import 'package:proxy_provider_for_filter/model/game_status_model_v1.dart';

import '../entities/gaming_model_entity.dart';
import '../model/game_type_model_v1.dart';
import '../model/gaming_model_v1.dart';
import '../sql_db/sql_repo.dart';
import '../utils/convert_maps_to_entity.dart'
    show convertMapToGamingEntitiy, keyidtable;

abstract class GamingRepo {
  Future<List<GameTypeModelV1>> getListGameTypeModel();
  Future<List<GameStatusModelV1>> getListGameStatusModel();
  Future<List<GamingModelEntity>> getListGamingHistory();
  Future<void> addGamingHistory(GamingModelV1 gamingEntity);
  Future<void> updateGamingHistory(GamingModelV1 gamingEntity);
}

class GamingRepoImpl implements GamingRepo {
  @override
  Future<List<GamingModelEntity>> getListGamingHistory() async {
    final sqlBase = SqlBaseRepoImpl();
    final resultFromQuery =
        await sqlBase.getListDataRawQuery<GamingModelEntity>(
      fromMap: convertMapToGamingEntitiy,
      rawQuery:
          "SELECT ${GamingModelV1.table}.${GamingModelV1.keyid} as $keyidtable,* FROM ${GamingModelV1.table} "
          "INNER JOIN ${GameTypeModelV1.table} ON ${GamingModelV1.table}.${GamingModelV1.keyidtype} = ${GameTypeModelV1.table}.${GameTypeModelV1.keyid} "
          "INNER JOIN ${GameStatusModelV1.table} ON ${GamingModelV1.table}.${GamingModelV1.keyidstatus} = ${GameStatusModelV1.table}.${GameStatusModelV1.keyid}",
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
    await sqlBase.insertData(GamingModelV1.table, gamingEntity.toMap());
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
