import 'package:proxy_provider_for_filter/entities/dropdown_item.dart';

import '../entities/gaming_model_entity.dart';
import '../entities/reading_model_entity.dart';
import '../entities/watching_model_entity.dart';
import '../model/game_status_model_v1.dart';
import '../model/game_type_model_v1.dart';
import '../model/gaming_model_v1.dart';
import '../model/read_status_model_v1.dart';
import '../model/read_type_model_v1.dart';
import '../model/reading_model_v1.dart';
import '../model/watch_status_model_v1.dart';
import '../model/watch_type_model_v1.dart';
import '../model/watching_model_v1.dart';
import 'convert_type.dart';

/// custom name id for used in 'as' keyword because the id been return is id from status table
const String keyidtable = "id_table";

WatchingModelEntity convertMapToWatchingEntitiy(Map<String, Object?> mapValue) {
  return WatchingModelEntity(
    id: convertType<int>(mapValue[keyidtable]) ?? 0,
    isFavorite: convertType<int>(mapValue[WatchingModelV1.keyfavorite]) == 1,
    name: convertType<String>(mapValue[WatchingModelV1.keyname]) ?? '',
    statusWatch: DropdownItem(
      key: convertType<String>(mapValue[WatchingModelV1.keyidstatus]) ?? '',
      title:
          convertType<String>(mapValue[WatchStatusModelV1.keynamestatus]) ?? '',
          
    ),
    typeWatch: DropdownItem(
      key: convertType<String>(mapValue[WatchingModelV1.keyidtype]) ?? '',
      title: convertType<String>(mapValue[WatchTypeModelV1.keynametype]) ?? '',
    ),
  );
}

ReadingModelEntity convertMapToReadingEntitiy(Map<String, Object?> mapValue) {
  return ReadingModelEntity(
    id: convertType<int>(mapValue[keyidtable]) ?? 0,
    isFavorite: convertType<int>(mapValue[ReadingModelV1.keyfavorite]) == 1,
    name: convertType<String>(mapValue[ReadingModelV1.keyname]) ?? '',
    statusRead: DropdownItem(
      key: convertType<String>(mapValue[ReadingModelV1.keyidstatus]) ?? '',
      title: convertType<String>(mapValue[ReadStatusModelV1.keynamestatus]) ?? '',
    ),
    typeRead: DropdownItem(
      key: convertType<String>(mapValue[ReadingModelV1.keyidtype]) ?? '',
      title: convertType<String>(mapValue[ReadTypeModelV1.keynametype]) ?? '',
    ),
  );
}

GamingModelEntity convertMapToGamingEntitiy(Map<String, Object?> mapValue) {
  return GamingModelEntity(
    id: convertType<int>(mapValue[keyidtable]) ?? 0,
    isFavorite: convertType<int>(mapValue[GamingModelV1.keyfavorite]) == 1,
    name: convertType<String>(mapValue[GamingModelV1.keyname]) ?? '',
    statusGame: DropdownItem(
      key: convertType<String>(mapValue[GamingModelV1.keyidstatus]) ?? '',
      title: convertType<String>(mapValue[GameStatusModelV1.keynamestatus]) ?? '',
    ),
    typeGame: DropdownItem(
      key: convertType<String>(mapValue[GamingModelV1.keyidtype]) ?? '',
      title: convertType<String>(mapValue[GameTypeModelV1.keynametype]) ?? '',
    ),
  );
}