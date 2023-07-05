import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/entities/base_dropdown_return.dart';
import 'package:proxy_provider_for_filter/entities/base_model_entity.dart';
import 'package:proxy_provider_for_filter/entities/gaming_model_entity.dart';

import '../entities/dropdown_item.dart';
import '../model/filter_model/filter_history_model.dart';
import '../local_data_source/gaming_local_data_source.dart';
import '../repository/gaming_repo.dart';
import 'base_provider.dart';
import 'filter_provider.dart';

class GamingProvider extends BaseProvider {
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
    final gamingRepoImpl = GamingRepoImpl(GamingLocalDataSourceImpl());
    final listResult = await gamingRepoImpl.getListFromListSource();
    onSuccess(listResult);
  }

  @override
  Future<void> processAddData({
    required BuildContext context,
    required BaseModelEntity inputModel,
    required void Function(List<BaseModelEntity> listItems) onSuccess,
  }) async {
    final gamingRepoImpl = GamingRepoImpl(GamingLocalDataSourceImpl());

    assert(inputModel is GamingModelEntity);
    if (inputModel is GamingModelEntity) {
      await gamingRepoImpl.addFromEntityToLocalSource(inputModel);
    }

    final listResult = await gamingRepoImpl.getListFromListSource();
    onSuccess(listResult);
  }

  @override
  Future<BaseDropdownReturn> processLoadDropdownData() async {
    final readingRepoImpl = GamingLocalDataSourceImpl();
    final listStatus = await readingRepoImpl.getListGameStatusModel();
    final listType = await readingRepoImpl.getListGameTypeModel();
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
  Future<void> processFilter({
    required BuildContext context,
    required void Function(List<BaseModelEntity> listItems) onSuccess,
  }) async {
    final filterData = FilterHistoryModel(
      statusId: filterProvider.status?.key,
      favorite: filterProvider.favorite,
      typeId: filterProvider.type?.key,
    );
    final gamingRepoImpl = GamingRepoImpl(GamingLocalDataSourceImpl());

    final listResult = await gamingRepoImpl.filterFromListSource(filterData);
    onSuccess(listResult);
  }

  @override
  Future<void> processUpdateData(
      {required BuildContext context,
      required BaseModelEntity inputModel,
      required void Function(List<BaseModelEntity> listItems)
          onSuccess}) async {
    final gamingRepoImpl = GamingRepoImpl(GamingLocalDataSourceImpl());

    assert(inputModel is GamingModelEntity);
    if (inputModel is GamingModelEntity) {
      await gamingRepoImpl.updateFromEntityToLocalSource(inputModel);
    }
    final listResult = await gamingRepoImpl.getListFromListSource();
    onSuccess(listResult);
  }
}
