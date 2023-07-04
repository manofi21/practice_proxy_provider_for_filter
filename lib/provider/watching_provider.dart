import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/entities/base_model_entity.dart';
import 'package:proxy_provider_for_filter/entities/dropdown_item.dart';
import 'package:proxy_provider_for_filter/model/filter_model/filter_history_model.dart';
import 'package:proxy_provider_for_filter/model/watching_model_v1.dart';
import 'package:proxy_provider_for_filter/provider/filter_provider.dart';
import '../entities/base_dropdown_return.dart';
import '../entities/watching_model_entity.dart';
import '../repo/watching_repo.dart';
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
    final watchRepoImpl = WatchingRepoImpl();
    final listResult = await watchRepoImpl.getListWatchingHistory();
    onSuccess(listResult);
  }

  @override
  Future<void> processAddData({
    required BuildContext context,
    required BaseModelEntity inputModel,
    required void Function(List<BaseModelEntity> listItems) onSuccess,
  }) async {
    final watchRepoImpl = WatchingRepoImpl();
    final createAtMilliSecond = DateTime.now().toUtc().millisecondsSinceEpoch;

    if (inputModel is WatchingModelEntity) {
      final watcingInputModel = WatchingModelV1(
        name: inputModel.name,
        isFavorite: inputModel.isFavorite ? 1 : 0,
        idStatusWatch: inputModel.statusWatch.key,
        idTypeWatch: inputModel.typeWatch.key,
        createAt: createAtMilliSecond,
      );
      await watchRepoImpl.addWatchingHistory(watcingInputModel);
    }

    final listResult = await watchRepoImpl.getListWatchingHistory();
    onSuccess(listResult);
  }

  @override
  Future<BaseDropdownReturn> processLoadDropdownData() async {
    final watchRepoImpl = WatchingRepoImpl();
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
    );
    final watchRepoImpl = WatchingRepoImpl();
    final listResult = await watchRepoImpl.getListWatchingHistory(
        filterHistoryModel: filterData);
    onSuccess(listResult);
  }

  @override
  Future<void> processUpdateData({
    required BuildContext context,
    required BaseModelEntity inputModel,
    required void Function(List<BaseModelEntity> listItems) onSuccess,
  }) async {
    final watchRepoImpl = WatchingRepoImpl();
    final updateAtAsMilliSecond = DateTime.now().toUtc().millisecondsSinceEpoch;
    assert(inputModel.createAt != null);

    final createAtMilliSecond =
        inputModel.createAt!.toUtc().millisecondsSinceEpoch;

    if (inputModel is WatchingModelEntity) {
      final watchingInputModel = WatchingModelV1(
        id: inputModel.id,
        name: inputModel.name,
        isFavorite: inputModel.isFavorite ? 1 : 0,
        idStatusWatch: inputModel.statusWatch.key,
        idTypeWatch: inputModel.typeWatch.key,
        createAt: createAtMilliSecond,
        updateAt: updateAtAsMilliSecond,
      );
      await watchRepoImpl.updateWatchingHistory(watchingInputModel);
    }
    final listResult = await watchRepoImpl.getListWatchingHistory();
    onSuccess(listResult);
  }
}
