import 'base_model_entity.dart';

class ReadingModelEntity extends BaseModelEntity{
  final String typeRead;
  final String statusRead;

  const ReadingModelEntity({
    required int id,
    required String name,
    required bool isFavorite,
    required this.typeRead,
    required this.statusRead,
  }): super(
            id: id,
            name: name,
            isFavorite: isFavorite,
            typeTitleName: typeRead,
            statusTitleName: statusRead);

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

  @override
  String toString() {
    return 'ReadingModelEntity(id: $id, name: $name, isFavorite: $isFavorite, typeRead: $typeRead, statusRead: $statusRead)';
  }
}
