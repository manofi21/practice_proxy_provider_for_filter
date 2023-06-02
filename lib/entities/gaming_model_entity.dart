class GamingModelEntity {
  final int id;
  final String name;
  final bool isFavorite;
  final String typeGame;
  final String statusGame;

  const GamingModelEntity({
    required this.id,
    required this.name,
    required this.isFavorite,
    required this.typeGame,
    required this.statusGame,
  });

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
  bool operator ==(covariant GamingModelEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.isFavorite == isFavorite &&
        other.typeGame == typeGame &&
        other.statusGame == statusGame;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        isFavorite.hashCode ^
        typeGame.hashCode ^
        statusGame.hashCode;
  }

  @override
  String toString() {
    return 'GamingModelEntity(id: $id, name: $name, isFavorite: $isFavorite, typeGame: $typeGame, statusGame: $statusGame)';
  }
}
