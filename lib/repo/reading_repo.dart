import 'package:proxy_provider_for_filter/model/read_status_model_v1.dart';

import '../entities/reading_model_entity.dart';
import '../model/read_type_model_v1.dart';
import '../model/reading_model_v1.dart';
import '../sql_db/sql_repo.dart';
import '../utils/convert_maps_to_entity.dart' show convertMapToReadingEntitiy, keyidtable;

abstract class ReadingRepo {
  Future<List<ReadingModelEntity>> getListReadingHistory();
  Future<void> addReadingHistory(ReadingModelV1 readingEntity);
  Future<void> updateReadingHistory(ReadingModelV1 readingEntity);
}

class ReadingRepoImpl implements ReadingRepo {
  @override
  Future<List<ReadingModelEntity>> getListReadingHistory() async {
    final sqlBase = SqlBaseRepoImpl();
    final resultFromQuery = await sqlBase.getListDataRawQuery<ReadingModelEntity>(
      fromMap: convertMapToReadingEntitiy,
      rawQuery: "SELECT ${ReadingModelV1.table}.${ReadingModelV1.keyid} as $keyidtable,* FROM ${ReadingModelV1.table} "
          "INNER JOIN ${ReadTypeModelV1.table} ON ${ReadingModelV1.table}.${ReadingModelV1.keyidtype} = ${ReadTypeModelV1.table}.${ReadTypeModelV1.keyid} "
          "INNER JOIN ${ReadStatusModelV1.table} ON ${ReadingModelV1.table}.${ReadingModelV1.keyidstatus} = ${ReadStatusModelV1.table}.${ReadStatusModelV1.keyid}",
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
    await sqlBase.insertData(ReadingModelV1.table, readingEntity.toMap());
  }
}
