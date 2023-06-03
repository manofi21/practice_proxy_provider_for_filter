import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/entities/base_model_entity.dart';

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
}
