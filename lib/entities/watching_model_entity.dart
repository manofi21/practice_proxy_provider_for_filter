import 'package:proxy_provider_for_filter/entities/dropdown_item.dart';

import 'base_model_entity.dart';

class WatchingModelEntity extends BaseModelEntity{
  final DropdownItem typeWatch;
  final DropdownItem statusWatch;

  WatchingModelEntity({
    int? id,
    required String name,
    required bool isFavorite,
    required this.typeWatch,
    required this.statusWatch,
  }): super(
            id: id,
            name: name,
            isFavorite: isFavorite,
            typeDropdown: typeWatch,
            statusDropdown: statusWatch);

  WatchingModelEntity copyWith({
    int? id,
    String? name,
    bool? isFavorite,
    DropdownItem? typeWatch,
    DropdownItem? statusWatch,
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
        other.typeDropdown == typeWatch &&
        other.statusDropdown == statusWatch;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        isFavorite.hashCode ^
        typeDropdown.hashCode ^
        statusDropdown.hashCode;
  }

  @override
  String toString() {
    return 'WatchingModelEntity(id: $id, name: $name, isFavorite: $isFavorite, typeWatch: ${typeWatch.title}, statusWatch: ${statusWatch.title})';
  }
}