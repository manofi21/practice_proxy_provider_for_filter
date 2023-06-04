import 'base_model_entity.dart';
import 'dropdown_item.dart';

class GamingModelEntity extends BaseModelEntity {
  final DropdownItem typeGame;
  final DropdownItem statusGame;

  GamingModelEntity({
    int? id,
    required String name,
    required bool isFavorite,
    required this.typeGame,
    required this.statusGame,
  }) : super(
            id: id,
            name: name,
            isFavorite: isFavorite,
            typeDropdown: typeGame,
            statusDropdown: statusGame);

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

  GamingModelEntity copyWith({
    int? id,
    String? name,
    bool? isFavorite,
    DropdownItem? typeGame,
    DropdownItem? statusGame,
  }) {
    return GamingModelEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      isFavorite: isFavorite ?? this.isFavorite,
      typeGame: typeGame ?? this.typeGame,
      statusGame: statusGame ?? this.statusGame,
    );
  }

  @override
  String toString() =>
      'GamingModelEntity(id: $id, name: $name, isFavorite: $isFavorite, typeGame: ${typeGame.title}, statusGame: ${statusGame.title})';
}