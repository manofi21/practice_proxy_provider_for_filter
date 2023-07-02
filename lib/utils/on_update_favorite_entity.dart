import 'package:proxy_provider_for_filter/entities/gaming_model_entity.dart';
import 'package:proxy_provider_for_filter/provider/gaming_provider.dart';
import 'package:proxy_provider_for_filter/provider/watching_provider.dart';

import '../entities/base_model_entity.dart';
import '../entities/reading_model_entity.dart';
import '../entities/watching_model_entity.dart';
import '../provider/base_provider.dart';
import '../provider/reading_provider.dart';

BaseModelEntity? onUpdateFavoriteEntity<BP extends BaseProvider>(
    {required BaseModelEntity inputModel}) {
  if (BP == GamingProvider && inputModel is GamingModelEntity) {
    return inputModel.copyWith(isFavorite: !inputModel.isFavorite);
  }

  if (BP == WatchingProvider && inputModel is WatchingModelEntity) {
    return inputModel.copyWith(isFavorite: !inputModel.isFavorite);
  }

  if (BP == ReadingProvider && inputModel is ReadingModelEntity) {
    return inputModel.copyWith(isFavorite: !inputModel.isFavorite);
  }

  return null;
}
