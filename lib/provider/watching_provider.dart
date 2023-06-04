import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/entities/base_model_entity.dart';
import 'package:proxy_provider_for_filter/model/watching_model_v1.dart';
import '../entities/watching_model_entity.dart';
import '../repo/watching_repo.dart';
import 'base_provider.dart';

class WatchingProvider extends BaseProvider {
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
    if (inputModel is WatchingModelEntity) {
      final watcingInputModel = WatchingModelV1(
        name: inputModel.name,
        isFavorite: inputModel.isFavorite ? 1 : 0,
        idStatusWatch: inputModel.statusWatch.key,
        idTypeWatch: inputModel.statusWatch.key,
      );
      await watchRepoImpl.addWatchingHistory(watcingInputModel);
    }

    final listResult = await watchRepoImpl.getListWatchingHistory();
    onSuccess(listResult);
  }
}
