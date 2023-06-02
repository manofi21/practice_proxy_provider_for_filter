class ReadingModelEntity {
  final int id;
  final String name;
  final bool isFavorite;
  final String typeRead;
  final String statusRead;

  const ReadingModelEntity({
    required this.id,
    required this.name,
    required this.isFavorite,
    required this.typeRead,
    required this.statusRead,
  });

  ReadingModelEntity copyWith({
    int? id,
    String? name,
    bool? isFavorite,
    String? typeRead,
    String? statusRead,
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
  bool operator ==(covariant ReadingModelEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.isFavorite == isFavorite &&
        other.typeRead == typeRead &&
        other.statusRead == statusRead;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        isFavorite.hashCode ^
        typeRead.hashCode ^
        statusRead.hashCode;
  }

  @override
  String toString() {
    return 'ReadingModelEntity(id: $id, name: $name, isFavorite: $isFavorite, typeRead: $typeRead, statusRead: $statusRead)';
  }
}
