import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/entities/base_dropdown_return.dart';
import 'package:proxy_provider_for_filter/entities/base_model_entity.dart';
import 'package:proxy_provider_for_filter/entities/gaming_model_entity.dart';
import 'package:proxy_provider_for_filter/model/gaming_model_v1.dart';

import '../entities/dropdown_item.dart';
import '../model/filter_model/filter_history_model.dart';
import '../repo/gaming_repo.dart';
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
    final gamingRepoImpl = GamingRepoImpl();
    final listResult = await gamingRepoImpl.getListGamingHistory();
    onSuccess(listResult);
  }

  @override
  Future<void> processAddData({
    required BuildContext context,
    required BaseModelEntity inputModel,
    required void Function(List<BaseModelEntity> listItems) onSuccess,
  }) async {
    final gamingRepoImpl = GamingRepoImpl();
    final createAtMilliSecond = DateTime.now().toUtc().millisecondsSinceEpoch;
    if (inputModel is GamingModelEntity) {
      final gamingInputModel = GamingModelV1(
        name: inputModel.name,
        isFavorite: inputModel.isFavorite ? 1 : 0,
        idStatusGame: inputModel.statusGame.key,
        idTypeGame: inputModel.typeGame.key,
        createAt: createAtMilliSecond,
      );
      await gamingRepoImpl.addGamingHistory(gamingInputModel);
    }

    final listResult = await gamingRepoImpl.getListGamingHistory();
    onSuccess(listResult);
  }

  @override
  Future<BaseDropdownReturn> processLoadDropdownData() async {
    final readingRepoImpl = GamingRepoImpl();
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
    );
    final gamingRepoImpl = GamingRepoImpl();
    final listResult = await gamingRepoImpl.getListGamingHistory(
        filterHistoryModel: filterData);
    onSuccess(listResult);
  }
  
  @override
  Future<void> processUpdateData({required BuildContext context, required BaseModelEntity inputModel, required void Function(List<BaseModelEntity> listItems) onSuccess}) async {
    final gamingRepoImpl = GamingRepoImpl();

    if (inputModel is GamingModelEntity) {
      final updateAtAsMilliSecond = DateTime.now().toUtc().millisecondsSinceEpoch;
      assert(inputModel.createAt != null);
      
      final createAtMilliSecond = inputModel.createAt!.toUtc().millisecondsSinceEpoch;
      final gamingInputModel = GamingModelV1(
        id: inputModel.id,
        name: inputModel.name,
        isFavorite: inputModel.isFavorite ? 1 : 0,
        idStatusGame: inputModel.statusGame.key,
        idTypeGame: inputModel.typeGame.key,
        createAt: createAtMilliSecond,
        updateAt: updateAtAsMilliSecond,
      );
      await gamingRepoImpl.updateGamingHistory(gamingInputModel);
    }
    final listResult = await gamingRepoImpl.getListGamingHistory();
    onSuccess(listResult);
  }
}
