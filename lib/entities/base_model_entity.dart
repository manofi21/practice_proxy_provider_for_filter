import 'dropdown_item.dart';

abstract class BaseModelEntity {
  int? id;
  final String name;
  final bool isFavorite;
  final DropdownItem typeDropdown;
  final DropdownItem statusDropdown;

  BaseModelEntity({
    this.id,
    required this.name,
    required this.isFavorite,
    required this.typeDropdown,
    required this.statusDropdown,
  });
}
