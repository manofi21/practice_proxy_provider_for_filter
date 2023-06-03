import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/entities/base_model_entity.dart';

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
}
