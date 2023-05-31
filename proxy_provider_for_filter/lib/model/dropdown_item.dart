class DropdownItem {
  DropdownItem({
    required this.key,
    this.title,
  });

  final String key;
  final String? title;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DropdownItem &&
        other.key == key &&
        other.title == title;
  }

  @override
  int get hashCode => key.hashCode ^ title.hashCode;
}