import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/entities/base_model_entity.dart';

import '../entities/reading_model_entity.dart';
import '../model/reading_model_v1.dart';
import '../repo/reading_repo.dart';
import 'base_provider.dart';

class ReadingProvider extends BaseProvider {
  @override
  Future<void> processInit({
    required BuildContext context,
    required void Function(List<BaseModelEntity> listItems) onSuccess,
  }) async {
    final watchRepoImpl = ReadingRepoImpl();
    final listResult = await watchRepoImpl.getListReadingHistory();
    onSuccess(listResult);
  }

  @override
  Future<void> processAddData({
    required BuildContext context,
    required BaseModelEntity inputModel,
    required void Function(List<BaseModelEntity> listItems) onSuccess,
  }) async {
    final watchRepoImpl = ReadingRepoImpl();
    if (inputModel is ReadingModelEntity) {
      final readingInputModel = ReadingModelV1(
        name: inputModel.name,
        isFavorite: inputModel.isFavorite ? 1 : 0,
        idStatusRead: inputModel.statusRead.key,
        idTypeRead: inputModel.typeRead.key,
      );
      await watchRepoImpl.addReadingHistory(readingInputModel);
    }

    final listResult = await watchRepoImpl.getListReadingHistory();
    onSuccess(listResult);
  }
}
