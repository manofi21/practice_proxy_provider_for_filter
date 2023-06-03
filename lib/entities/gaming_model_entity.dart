import 'base_model_entity.dart';

class GamingModelEntity extends BaseModelEntity {
  final String typeGame;
  final String statusGame;

  const GamingModelEntity({
    required int id,
    required String name,
    required bool isFavorite,
    required this.typeGame,
    required this.statusGame,
  }) : super(
            id: id,
            name: name,
            isFavorite: isFavorite,
            typeTitleName: typeGame,
            statusTitleName: statusGame);

  @override
  bool operator ==(covariant BaseModelEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.isFavorite == isFavorite &&
        other.typeTitleName == typeTitleName &&
        other.statusTitleName == statusTitleName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        isFavorite.hashCode ^
        typeTitleName.hashCode ^
        statusTitleName.hashCode;
  }

  GamingModelEntity copyWith({
    int? id,
    String? name,
    bool? isFavorite,
    String? typeGame,
    String? statusGame,
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
      'GamingModelEntity(id: $id, name: $name, isFavorite: $isFavorite, typeGame: $typeGame, statusGame: $statusGame)';
}