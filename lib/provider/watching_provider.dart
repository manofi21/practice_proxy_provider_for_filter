import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/entities/base_model_entity.dart';
import 'package:proxy_provider_for_filter/entities/dropdown_item.dart';
import 'package:proxy_provider_for_filter/model/filter_model/filter_history_model.dart';
import 'package:proxy_provider_for_filter/provider/filter_provider.dart';
import '../entities/base_dropdown_return.dart';
import '../entities/watching_model_entity.dart';
import '../local_data_source/watching_local_data_source.dart';
import '../repository/watching_repo.dart';
import 'base_provider.dart';

class WatchingProvider extends BaseProvider {
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
    final watchRepoImpl = WatchingRepoImpl(WatchingLocalDataSourceImpl());
    final listResult = await watchRepoImpl.getListFromListSource();
    onSuccess(listResult);
  }

  @override
  Future<void> processAddData({
    required BuildContext context,
    required BaseModelEntity inputModel,
    required void Function(List<BaseModelEntity> listItems) onSuccess,
  }) async {
    final watchRepoImpl = WatchingRepoImpl(WatchingLocalDataSourceImpl());

    assert(inputModel is WatchingModelEntity);
    if (inputModel is WatchingModelEntity) {
      await watchRepoImpl.addFromEntityToLocalSource(inputModel);
    }

    final listResult = await watchRepoImpl.getListFromListSource();
    onSuccess(listResult);
  }

  @override
  Future<BaseDropdownReturn> processLoadDropdownData() async {
    final watchRepoImpl = WatchingLocalDataSourceImpl();
    final listStatus = await watchRepoImpl.getListWatcStatusModel();
    final listType = await watchRepoImpl.getListWatchTypeModel();

    // Adding Deleyed for showing circular indicator
    await Future.delayed(const Duration(seconds: 1));
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
    final watchRepoImpl = WatchingRepoImpl(WatchingLocalDataSourceImpl());

    final listResult = await watchRepoImpl.filterFromListSource(filterData);
    onSuccess(listResult);
  }

  @override
  Future<void> processUpdateData({
    required BuildContext context,
    required BaseModelEntity inputModel,
    required void Function(List<BaseModelEntity> listItems) onSuccess,
  }) async {
    final watchRepoImpl = WatchingRepoImpl(WatchingLocalDataSourceImpl());

    assert(inputModel is WatchingModelEntity);
    if (inputModel is WatchingModelEntity) {
      await watchRepoImpl.updateFromEntityToLocalSource(inputModel);
    }
    final listResult = await watchRepoImpl.getListFromListSource();
    onSuccess(listResult);
  }
}
