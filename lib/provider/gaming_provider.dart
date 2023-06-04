import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/entities/base_model_entity.dart';
import 'package:proxy_provider_for_filter/entities/gaming_model_entity.dart';
import 'package:proxy_provider_for_filter/model/gaming_model_v1.dart';

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
}
