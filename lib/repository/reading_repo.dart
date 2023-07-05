import '../entities/reading_model_entity.dart';
import '../local_data_source/reading_local_data_source.dart';
import '../model/filter_model/filter_history_model.dart';
import '../model/reading_model_v1.dart';
import 'repo.dart';
import 'convert_maps_to_entity.dart' show convertMapToReadingEntitiy;

class ReadingRepoImpl implements Repo<ReadingModelEntity> {
  final ReadingLocalDataSource localDataSource;
  ReadingRepoImpl(this.localDataSource);

  @override
  Future<void> addFromEntityToLocalSource(ReadingModelEntity addedItem) async {
    final createAtMilliSecond = DateTime.now().toUtc().millisecondsSinceEpoch;

    final readingInputModel = ReadingModelV1(
      name: addedItem.name,
      isFavorite: addedItem.isFavorite ? 1 : 0,
      idStatusRead: addedItem.statusRead.key,
      idTypeRead: addedItem.typeRead.key,
      createAt: createAtMilliSecond,
    );
    await localDataSource.addReadingHistory(readingInputModel);
  }

  @override
  Future<List<ReadingModelEntity>> filterFromListSource(
      FilterHistoryModel filterHistoryModel) async {
    final filterModel = filterHistoryModel.toStringFilterQUery(
      ReadingModelV1.table,
      columnStatusId: ReadingModelV1.keyidstatus,
      columnFavorite: ReadingModelV1.keyfavorite,
      columnTypeId: ReadingModelV1.keyidtype,
    );
    final whereQuery = filterModel.whereQuery;
    final whereArgument = filterModel.argument;
    final getListDynamic = await localDataSource.getListReadingHistory(
      whereQuery: whereQuery,
      whereArgument: whereArgument,
    );

    final listResult = getListDynamic.map(convertMapToReadingEntitiy).toList();
    return listResult;
  }

  @override
  Future<List<ReadingModelEntity>> getListFromListSource() async {
    final getListDynamic = await localDataSource.getListReadingHistory();
    final listResult = getListDynamic.map(convertMapToReadingEntitiy).toList();
    return listResult;
  }

  @override
  Future<void> updateFromEntityToLocalSource(ReadingModelEntity addedItem) async {
    final updateAtAsMilliSecond = DateTime.now().toUtc().millisecondsSinceEpoch;
    assert(addedItem.createAt != null);

    final createAtMilliSecond =
        addedItem.createAt!.toUtc().millisecondsSinceEpoch;

      final readingInputModel = ReadingModelV1(
        id: addedItem.id,
        name: addedItem.name,
        isFavorite: addedItem.isFavorite ? 1 : 0,
        idStatusRead: addedItem.statusRead.key,
        idTypeRead: addedItem.typeRead.key,
        createAt: createAtMilliSecond,
        updateAt: updateAtAsMilliSecond,
      );
      await localDataSource.updateReadingHistory(readingInputModel);
  }
}
