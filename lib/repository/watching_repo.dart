import '../entities/watching_model_entity.dart';
import '../local_data_source/watching_local_data_source.dart';
import '../model/filter_model/filter_history_model.dart';
import '../model/watching_model_v1.dart';
import 'repo.dart';
import 'convert_maps_to_entity.dart' show convertMapToWatchingEntitiy;

class WatchingRepoImpl implements Repo<WatchingModelEntity> {
  final WatchingLocalDataSource localDataSource;
  WatchingRepoImpl(this.localDataSource);

  @override
  Future<void> addFromEntityToLocalSource(WatchingModelEntity addedItem) async {
    final createAtMilliSecond = DateTime.now().toUtc().millisecondsSinceEpoch;

    final watcingInputModel = WatchingModelV1(
      name: addedItem.name,
      isFavorite: addedItem.isFavorite ? 1 : 0,
      idStatusWatch: addedItem.statusWatch.key,
      idTypeWatch: addedItem.typeWatch.key,
      createAt: createAtMilliSecond,
    );
    await localDataSource.addWatchingHistory(watcingInputModel);
  }

  @override
  Future<List<WatchingModelEntity>> filterFromListSource(
      FilterHistoryModel filterHistoryModel) async {
    final filterModel = filterHistoryModel.toStringFilterQUery(
      WatchingModelV1.table,
      columnStatusId: WatchingModelV1.keyidstatus,
      columnFavorite: WatchingModelV1.keyfavorite,
      columnTypeId: WatchingModelV1.keyidtype,
      columnCreateAt: WatchingModelV1.keycreateAt,
      // columnUpdateAt: WatchingModelV1.keyupdateAt,
    );
    final whereQuery = filterModel.whereQuery;
    final whereArgument = filterModel.argument;
    final getListDynamic = await localDataSource.getListWatchingHistory(
      whereQuery: whereQuery,
      whereArgument: whereArgument,
    );

    final listResult = getListDynamic.map(convertMapToWatchingEntitiy).toList();
    return listResult;
  }

  @override
  Future<List<WatchingModelEntity>> getListFromListSource() async {
    final getListDynamic = await localDataSource.getListWatchingHistory();
    final listResult = getListDynamic.map(convertMapToWatchingEntitiy).toList();
    return listResult;
  }

  @override
  Future<void> updateFromEntityToLocalSource(WatchingModelEntity addedItem) async {
    final updateAtAsMilliSecond = DateTime.now().toUtc().millisecondsSinceEpoch;
    assert(addedItem.createAt != null);

    final createAtMilliSecond =
        addedItem.createAt!.toUtc().millisecondsSinceEpoch;

      final watchingInputModel = WatchingModelV1(
        id: addedItem.id,
        name: addedItem.name,
        isFavorite: addedItem.isFavorite ? 1 : 0,
        idStatusWatch: addedItem.statusWatch.key,
        idTypeWatch: addedItem.typeWatch.key,
        createAt: createAtMilliSecond,
        updateAt: updateAtAsMilliSecond,
      );
      await localDataSource.updateWatchingHistory(watchingInputModel);
  }
}
