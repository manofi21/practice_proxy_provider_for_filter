import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/entities/base_dropdown_return.dart';
import 'package:proxy_provider_for_filter/entities/base_model_entity.dart';

import '../entities/dropdown_item.dart';
import '../entities/reading_model_entity.dart';
import '../model/filter_model/filter_history_model.dart';
import '../model/reading_model_v1.dart';
import '../repo/reading_repo.dart';
import 'base_provider.dart';
import 'filter_provider.dart';

class ReadingProvider extends BaseProvider {
  late FilterProvider filterProvider;
  void initFilterProv(FilterProvider filterProvider) {
    this.filterProvider = filterProvider;
    notifyListeners();
  }

  @override
  Future<void> processInit({
    required BuildContext context,
    required void Function(List<BaseModelEntity> listItems) onSuccess,
  }) async {
    final readhRepoImpl = ReadingRepoImpl();
    final listResult = await readhRepoImpl.getListReadingHistory();
    onSuccess(listResult);
  }

  @override
  Future<void> processAddData({
    required BuildContext context,
    required BaseModelEntity inputModel,
    required void Function(List<BaseModelEntity> listItems) onSuccess,
  }) async {
    final readhRepoImpl = ReadingRepoImpl();
    final createAtMilliSecond = DateTime.now().toUtc().millisecondsSinceEpoch;

    if (inputModel is ReadingModelEntity) {
      final readingInputModel = ReadingModelV1(
        name: inputModel.name,
        isFavorite: inputModel.isFavorite ? 1 : 0,
        idStatusRead: inputModel.statusRead.key,
        idTypeRead: inputModel.typeRead.key,
        createAt: createAtMilliSecond,
      );
      await readhRepoImpl.addReadingHistory(readingInputModel);
    }

    final listResult = await readhRepoImpl.getListReadingHistory();
    onSuccess(listResult);
  }

  @override
  Future<BaseDropdownReturn> processLoadDropdownData() async {
    final readingRepoImpl = ReadingRepoImpl();
    final listStatus = await readingRepoImpl.getListReadStatusModel();
    final listType = await readingRepoImpl.getListReadTypeModel();
    return BaseDropdownReturn(
      listStatus: listStatus
          .map((e) => DropdownItem(key: e.id, title: e.nameStatus))
          .toList(),
      listType: listType
          .map((e) => DropdownItem(key: e.id, title: e.nameType))
          .toList(),
    );
  }

  @override
  Future<void> processFilter(
      {required BuildContext context,
      required void Function(List<BaseModelEntity> listItems)
          onSuccess}) async {
    final filterData = FilterHistoryModel(
      statusId: filterProvider.status?.key,
      favorite: filterProvider.favorite,
      typeId: filterProvider.type?.key,
    );
    final readRepoImpl = ReadingRepoImpl();
    final listResult = await readRepoImpl.getListReadingHistory(
        filterHistoryModel: filterData);
    onSuccess(listResult);
  }

  @override
  Future<void> processUpdateData(
      {required BuildContext context,
      required BaseModelEntity inputModel,
      required void Function(List<BaseModelEntity> listItems)
          onSuccess}) async {
    final readingRepoImpl = ReadingRepoImpl();
    final updateAtAsMilliSecond = DateTime.now().toUtc().millisecondsSinceEpoch;
    assert(inputModel.createAt != null);

    final createAtMilliSecond =
        inputModel.createAt!.toUtc().millisecondsSinceEpoch;

    if (inputModel is ReadingModelEntity) {
      final readingInputModel = ReadingModelV1(
        id: inputModel.id,
        name: inputModel.name,
        isFavorite: inputModel.isFavorite ? 1 : 0,
        idStatusRead: inputModel.statusRead.key,
        idTypeRead: inputModel.typeRead.key,
        createAt: createAtMilliSecond,
        updateAt: updateAtAsMilliSecond,
      );
      await readingRepoImpl.updateReadingHistory(readingInputModel);
    }
    final listResult = await readingRepoImpl.getListReadingHistory();
    onSuccess(listResult);
  }
}
