import 'base_model_entity.dart';
import 'dropdown_item.dart';

class GamingModelEntity extends BaseModelEntity {
  final DropdownItem typeGame;
  final DropdownItem statusGame;

  GamingModelEntity({
    int? id,
    required String name,
    required bool isFavorite,
    DateTime? createAt,
    DateTime? updateAt,
    required this.typeGame,
    required this.statusGame,
  }) : super(
          id: id,
          name: name,
          isFavorite: isFavorite,
          typeDropdown: typeGame,
          statusDropdown: statusGame,
          createAt: createAt,
          updateAt: updateAt,
        );

  @override
  bool operator ==(covariant BaseModelEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.isFavorite == isFavorite &&
        other.typeDropdown == typeDropdown &&
        other.statusDropdown == statusDropdown &&
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

  GamingModelEntity copyWith({
    int? id,
    String? name,
    bool? isFavorite,
    DropdownItem? typeGame,
    DropdownItem? statusGame,
    DateTime? createAt,
    DateTime? updateAt,
  }) {
    return GamingModelEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      isFavorite: isFavorite ?? this.isFavorite,
      typeGame: typeGame ?? this.typeGame,
      statusGame: statusGame ?? this.statusGame,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  @override
  String toString() =>
      'GamingModelEntity(id: $id, name: $name, isFavorite: $isFavorite, typeGame: ${typeGame.title}, statusGame: ${statusGame.title})';
}
