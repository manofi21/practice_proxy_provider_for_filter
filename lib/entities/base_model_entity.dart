import 'dropdown_item.dart';

abstract class BaseModelEntity {
  int? id;
  final String name;
  final bool isFavorite;
  final DropdownItem typeDropdown;
  final DropdownItem statusDropdown;
  final DateTime? createAt;
  final DateTime? updateAt;

  BaseModelEntity({
    this.id,
    required this.name,
    required this.isFavorite,
    required this.typeDropdown,
    required this.statusDropdown,
    required this.createAt, 
    required this.updateAt,
  });
}
