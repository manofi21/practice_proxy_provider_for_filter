import 'package:proxy_provider_for_filter/entities/dropdown_item.dart';

import 'base_model_entity.dart';

class WatchingModelEntity extends BaseModelEntity {
  final DropdownItem typeWatch;
  final DropdownItem statusWatch;

  WatchingModelEntity({
    int? id,
    required String name,
    required bool isFavorite,
    DateTime? createAt,
    DateTime? updateAt,
    required this.typeWatch,
    required this.statusWatch,
  }) : super(
          id: id,
          name: name,
          isFavorite: isFavorite,
          typeDropdown: typeWatch,
          statusDropdown: statusWatch,
          createAt: createAt,
          updateAt: updateAt,
        );

  WatchingModelEntity copyWith({
    int? id,
    String? name,
    bool? isFavorite,
    DropdownItem? typeWatch,
    DropdownItem? statusWatch,
    DateTime? createAt,
    DateTime? updateAt,
  }) {
    return WatchingModelEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      isFavorite: isFavorite ?? this.isFavorite,
      typeWatch: typeWatch ?? this.typeWatch,
      statusWatch: statusWatch ?? this.statusWatch,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  @override
  bool operator ==(covariant BaseModelEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.isFavorite == isFavorite &&
        other.typeDropdown == typeWatch &&
        other.statusDropdown == statusWatch &&
        other.createAt == createAt &&
        other.updateAt == updateAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        isFavorite.hashCode ^
        typeDropdown.hashCode ^
        statusDropdown.hashCode ^
        createAt.hashCode ^
        updateAt.hashCode;
  }

  @override
  String toString() {
    return 'WatchingModelEntity(id: $id, name: $name, isFavorite: $isFavorite, typeWatch: ${typeWatch.title}, statusWatch: ${statusWatch.title})';
  }
}
