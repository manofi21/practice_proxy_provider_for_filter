abstract class BaseModelEntity {
  final int id;
  final String name;
  final bool isFavorite;
  final String typeTitleName;
  final String statusTitleName;

  const BaseModelEntity({
    required this.id,
    required this.name,
    required this.isFavorite,
    required this.typeTitleName,
    required this.statusTitleName,
  });
}
