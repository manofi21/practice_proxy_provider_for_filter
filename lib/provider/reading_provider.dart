import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/entities/base_dropdown_return.dart';
import 'package:proxy_provider_for_filter/entities/base_model_entity.dart';

import '../entities/dropdown_item.dart';
import '../entities/reading_model_entity.dart';
import '../model/filter_model/filter_history_model.dart';
import '../local_data_source/reading_local_data_source.dart';
import '../repository/reading_repo.dart';
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
    final readRepoImpl = ReadingRepoImpl(ReadingLocalDataSourceImpl());
    final listResult = await readRepoImpl.getListFromListSource();
    onSuccess(listResult);
  }

  @override
  Future<void> processAddData({
    required BuildContext context,
    required BaseModelEntity inputModel,
    required void Function(List<BaseModelEntity> listItems) onSuccess,
  }) async {
    final readRepoImpl = ReadingRepoImpl(ReadingLocalDataSourceImpl());

    assert(inputModel is ReadingModelEntity);
    if (inputModel is ReadingModelEntity) {
      await readRepoImpl.addFromEntityToLocalSource(inputModel);
    }

    final listResult = await readRepoImpl.getListFromListSource();
    onSuccess(listResult);
  }

  @override
  Future<BaseDropdownReturn> processLoadDropdownData() async {
    final readingRepoImpl = ReadingLocalDataSourceImpl();
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
      startDate: filterProvider.startDate,
      endDate: filterProvider.endDate,
    );
    final readRepoImpl = ReadingRepoImpl(ReadingLocalDataSourceImpl());

    final listResult = await readRepoImpl.filterFromListSource(filterData);
    onSuccess(listResult);
  }

  @override
  Future<void> processUpdateData(
      {required BuildContext context,
      required BaseModelEntity inputModel,
      required void Function(List<BaseModelEntity> listItems)
          onSuccess}) async {
    final readRepoImpl = ReadingRepoImpl(ReadingLocalDataSourceImpl());

    assert(inputModel is ReadingModelEntity);
    if (inputModel is ReadingModelEntity) {
      await readRepoImpl.updateFromEntityToLocalSource(inputModel);
    }
    final listResult = await readRepoImpl.getListFromListSource();
    onSuccess(listResult);
  }
}
