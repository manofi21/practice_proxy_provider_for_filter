import '../entities/gaming_model_entity.dart';
import '../local_data_source/gaming_local_data_source.dart';
import '../model/filter_model/filter_history_model.dart';
import '../model/gaming_model_v1.dart';
import 'repo.dart';
import 'convert_maps_to_entity.dart' show convertMapToGamingEntitiy;

class GamingRepoImpl implements Repo<GamingModelEntity> {
  final GamingLocalDataSource localDataSource;
  GamingRepoImpl(this.localDataSource);

  @override
  Future<void> addFromEntityToLocalSource(GamingModelEntity addedItem) async {
    final createAtMilliSecond = DateTime.now().toUtc().millisecondsSinceEpoch;

    final gamingInputModel = GamingModelV1(
      name: addedItem.name,
      isFavorite: addedItem.isFavorite ? 1 : 0,
      idStatusGame: addedItem.statusGame.key,
      idTypeGame: addedItem.typeGame.key,
      createAt: createAtMilliSecond,
    );
    await localDataSource.addGamingHistory(gamingInputModel);
  }

  @override
  Future<List<GamingModelEntity>> filterFromListSource(
      FilterHistoryModel filterHistoryModel) async {
    final filterModel = filterHistoryModel.toStringFilterQUery(
      GamingModelV1.table,
      columnStatusId: GamingModelV1.keyidstatus,
      columnFavorite: GamingModelV1.keyfavorite,
      columnTypeId: GamingModelV1.keyidtype,
    );
    final whereQuery = filterModel.whereQuery;
    final whereArgument = filterModel.argument;
    final getListDynamic = await localDataSource.getListGamingHistory(
      whereQuery: whereQuery,
      whereArgument: whereArgument,
    );

    final listResult = getListDynamic.map(convertMapToGamingEntitiy).toList();
    return listResult;
  }

  @override
  Future<List<GamingModelEntity>> getListFromListSource() async {
    final getListDynamic = await localDataSource.getListGamingHistory();
    final listResult = getListDynamic.map(convertMapToGamingEntitiy).toList();
    return listResult;
  }

  @override
  Future<void> updateFromEntityToLocalSource(GamingModelEntity addedItem) async {
    final updateAtAsMilliSecond = DateTime.now().toUtc().millisecondsSinceEpoch;
    assert(addedItem.createAt != null);

    final createAtMilliSecond =
        addedItem.createAt!.toUtc().millisecondsSinceEpoch;

      final gamingInputModel = GamingModelV1(
        id: addedItem.id,
        name: addedItem.name,
        isFavorite: addedItem.isFavorite ? 1 : 0,
        idStatusGame: addedItem.statusGame.key,
        idTypeGame: addedItem.typeGame.key,
        createAt: createAtMilliSecond,
        updateAt: updateAtAsMilliSecond,
      );
      await localDataSource.updateGamingHistory(gamingInputModel);
  }
}
