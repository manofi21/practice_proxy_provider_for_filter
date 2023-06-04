abstract class BaseModelV1 {
  final int? id;
  final String name;
  final int isFavorite;
  final String idType;
  final String idStatus;

  const BaseModelV1({
    this.id,
    required this.name,
    required this.isFavorite,
    required this.idType,
    required this.idStatus,
  });
}
