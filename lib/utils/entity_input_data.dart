import 'package:proxy_provider_for_filter/entities/dropdown_item.dart';
import 'package:proxy_provider_for_filter/entities/gaming_model_entity.dart';
import 'package:proxy_provider_for_filter/provider/gaming_provider.dart';
import 'package:proxy_provider_for_filter/provider/watching_provider.dart';

import '../entities/base_model_entity.dart';
import '../entities/reading_model_entity.dart';
import '../entities/watching_model_entity.dart';
import '../provider/base_provider.dart';
import '../provider/reading_provider.dart';

BaseModelEntity? entityInputData<BP extends BaseProvider>({
  required String name,
  required bool isFavorite,
  required DropdownItem statusDropdown,
  required DropdownItem typeDropdown,
}) {
  if (BP == GamingProvider) {
    return GamingModelEntity(
      id: 0,
      name: name,
      isFavorite: isFavorite,
      typeGame: typeDropdown,
      statusGame: statusDropdown,
    );
  }

  if (BP == WatchingProvider) {
    return WatchingModelEntity(
      id: 0,
      name: name,
      isFavorite: isFavorite,
      typeWatch: typeDropdown,
      statusWatch: statusDropdown,
    );
  }

    if (BP == ReadingProvider) {
    return ReadingModelEntity(
      id: 0,
      name: name,
      isFavorite: isFavorite,
      typeRead: typeDropdown,
      statusRead: statusDropdown,
    );
  }

  return null;
}
