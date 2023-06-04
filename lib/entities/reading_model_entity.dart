import 'package:proxy_provider_for_filter/entities/dropdown_item.dart';

import 'base_model_entity.dart';

class ReadingModelEntity extends BaseModelEntity{
  final DropdownItem typeRead;
  final DropdownItem statusRead;

  ReadingModelEntity({
    int? id,
    required String name,
    required bool isFavorite,
    required this.typeRead,
    required this.statusRead,
  }): super(
            id: id,
            name: name,
            isFavorite: isFavorite,
            typeDropdown: typeRead,
            statusDropdown: statusRead);

  ReadingModelEntity copyWith({
    int? id,
    String? name,
    bool? isFavorite,
    DropdownItem? typeRead,
    DropdownItem? statusRead,
  }) {
    return ReadingModelEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      isFavorite: isFavorite ?? this.isFavorite,
      typeRead: typeRead ?? this.typeRead,
      statusRead: statusRead ?? this.statusRead,
    );
  }

  @override
  bool operator ==(covariant BaseModelEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.isFavorite == isFavorite &&
        other.typeDropdown == typeDropdown &&
        other.statusDropdown == statusDropdown;
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
    return 'ReadingModelEntity(id: $id, name: $name, isFavorite: $isFavorite, typeRead: ${typeRead.title}, statusRead: ${statusRead.title})';
  }
}
