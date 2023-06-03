import 'package:proxy_provider_for_filter/model/watch_type_model_v1.dart';
import 'package:proxy_provider_for_filter/utils/convert_type.dart';

import '../model/watch_status_model_v1.dart';
import '../model/watching_model_v1.dart';
import 'base_model_entity.dart';

class WatchingModelEntity extends BaseModelEntity{
  final String typeWatch;
  final String statusWatch;

  const WatchingModelEntity({
    required int id,
    required String name,
    required bool isFavorite,
    required this.typeWatch,
    required this.statusWatch,
  }): super(
            id: id,
            name: name,
            isFavorite: isFavorite,
            typeTitleName: typeWatch,
            statusTitleName: statusWatch);

  WatchingModelEntity copyWith({
    int? id,
    String? name,
    bool? isFavorite,
    String? typeWatch,
    String? statusWatch,
  }) {
    return WatchingModelEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      isFavorite: isFavorite ?? this.isFavorite,
      typeWatch: typeWatch ?? this.typeWatch,
      statusWatch: statusWatch ?? this.statusWatch,
    );
  }

  @override
  bool operator ==(covariant BaseModelEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.isFavorite == isFavorite &&
        other.typeTitleName == typeWatch &&
        other.statusTitleName == statusWatch;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        isFavorite.hashCode ^
        typeTitleName.hashCode ^
        statusTitleName.hashCode;
  }

  @override
  String toString() {
    return 'WatchingModelEntity(id: $id, name: $name, isFavorite: $isFavorite, typeWatch: $typeWatch, statusWatch: $statusWatch)';
  }
}

WatchingModelEntity convertMapToEntitiy(Map<String, Object?> mapValue){
  return WatchingModelEntity(
    id: convertType<int>(mapValue[WatchingModelV1.keyidtable]) ?? 0,
    isFavorite: convertType<int>(mapValue[WatchingModelV1.keyfavorite]) == 1,
    name: convertType<String>(mapValue[WatchingModelV1.keyname]) ?? '',
    statusWatch: convertType<String>(mapValue[WatchStatusModelV1.keynamestatus]) ?? '',
    typeWatch: convertType<String>(mapValue[WatchTypeModelV1.keynametype]) ?? '',
  );
}