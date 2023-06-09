import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/entities/base_dropdown_return.dart';
import 'package:proxy_provider_for_filter/entities/base_model_entity.dart';
import 'package:proxy_provider_for_filter/entities/gaming_model_entity.dart';
import 'package:proxy_provider_for_filter/model/gaming_model_v1.dart';

import '../entities/dropdown_item.dart';
import '../repo/gaming_repo.dart';
import 'base_provider.dart';

class GamingProvider extends BaseProvider {
  @override
  Future<void> processInit({
    required BuildContext context,
    required void Function(List<BaseModelEntity> listItems) onSuccess,
  }) async {
    final watchRepoImpl = GamingRepoImpl();
    final listResult = await watchRepoImpl.getListGamingHistory();
    onSuccess(listResult);
  }

  @override
  Future<void> processAddData({
    required BuildContext context,
    required BaseModelEntity inputModel,
    required void Function(List<BaseModelEntity> listItems) onSuccess,
  }) async {
    final watchRepoImpl = GamingRepoImpl();
    if (inputModel is GamingModelEntity) {
      final gamingInputModel = GamingModelV1(
        name: inputModel.name,
        isFavorite: inputModel.isFavorite ? 1 : 0,
        idStatusGame: inputModel.statusGame.key,
        idTypeGame: inputModel.typeGame.key,
      );
      await watchRepoImpl.addGamingHistory(gamingInputModel);
    }

    final listResult = await watchRepoImpl.getListGamingHistory();
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
}
