import 'package:proxy_provider_for_filter/entities/dropdown_item.dart';

import '../entities/date_time_result_from_query.dart';
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

extension ForMapToDateTime on Map<String, Object?> {
  DateTimeResultFromQuery convertToDateTime({
    required String keyCreateAt,
    required String keyupdateAt,
  }) {
    final createAt = DateTime.fromMillisecondsSinceEpoch(
        convertType<int>(this[keyCreateAt]) ?? 0,
        isUtc: false);
    final updateAt = this[keyupdateAt] != null
        ? DateTime.fromMillisecondsSinceEpoch(
            convertType<int>(this[keyupdateAt])!,
            isUtc: false)
        : null;
    return DateTimeResultFromQuery(createAt, updateAt);
  }
}

WatchingModelEntity convertMapToWatchingEntitiy(Map<String, Object?> mapValue) {
  final convertDateTimeResult = mapValue.convertToDateTime(
    keyCreateAt: WatchingModelV1.keycreateAt,
    keyupdateAt: WatchingModelV1.keyupdateAt,
  );
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
    createAt: convertDateTimeResult.createAt,
    updateAt: convertDateTimeResult.updateAt,
  );
}

ReadingModelEntity convertMapToReadingEntitiy(Map<String, Object?> mapValue) {
  final convertDateTimeResult = mapValue.convertToDateTime(
    keyCreateAt: ReadingModelV1.keycreateAt,
    keyupdateAt: ReadingModelV1.keyupdateAt,
  );

  return ReadingModelEntity(
    id: convertType<int>(mapValue[keyidtable]) ?? 0,
    isFavorite: convertType<int>(mapValue[ReadingModelV1.keyfavorite]) == 1,
    name: convertType<String>(mapValue[ReadingModelV1.keyname]) ?? '',
    statusRead: DropdownItem(
      key: convertType<String>(mapValue[ReadingModelV1.keyidstatus]) ?? '',
      title:
          convertType<String>(mapValue[ReadStatusModelV1.keynamestatus]) ?? '',
    ),
    typeRead: DropdownItem(
      key: convertType<String>(mapValue[ReadingModelV1.keyidtype]) ?? '',
      title: convertType<String>(mapValue[ReadTypeModelV1.keynametype]) ?? '',
    ),
    createAt: convertDateTimeResult.createAt,
    updateAt: convertDateTimeResult.updateAt,
  );
}

GamingModelEntity convertMapToGamingEntitiy(Map<String, Object?> mapValue) {
  final convertDateTimeResult = mapValue.convertToDateTime(
    keyCreateAt: GamingModelV1.keycreateAt,
    keyupdateAt: GamingModelV1.keyupdateAt,
  );

  return GamingModelEntity(
    id: convertType<int>(mapValue[keyidtable]) ?? 0,
    isFavorite: convertType<int>(mapValue[GamingModelV1.keyfavorite]) == 1,
    name: convertType<String>(mapValue[GamingModelV1.keyname]) ?? '',
    statusGame: DropdownItem(
      key: convertType<String>(mapValue[GamingModelV1.keyidstatus]) ?? '',
      title:
          convertType<String>(mapValue[GameStatusModelV1.keynamestatus]) ?? '',
    ),
    typeGame: DropdownItem(
      key: convertType<String>(mapValue[GamingModelV1.keyidtype]) ?? '',
      title: convertType<String>(mapValue[GameTypeModelV1.keynametype]) ?? '',
    ),
    createAt: convertDateTimeResult.createAt,
    updateAt: convertDateTimeResult.updateAt,
  );
}