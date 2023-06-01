import 'package:flutter/material.dart';

import '../model/dropdown_item.dart';
import '../theme/theme_value.dart';

class DropdownField extends StatefulWidget {
  const DropdownField(
      {Key? key,
      required this.items,
      required this.onChange,
      this.initialValue})
      : super(key: key);

  /// Callback on change action on dropdown
  final Function(DropdownItem?) onChange;

  /// list items of dropdown selection item
  final List<DropdownItem> items;

  /// variable initial value
  final DropdownItem? initialValue;

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  @override
  Widget build(BuildContext context) {
    var initialValue = widget.initialValue;

    final dropdown = DropdownButton<DropdownItem>(
      hint: const Text("Please Select"),
      icon: const Icon(Icons.keyboard_arrow_down),
      isExpanded: true,
      underline: const Offstage(),
      onChanged: (dropDown) {
        setState(() {
          initialValue = dropDown;
        });
        widget.onChange(dropDown);
      },
      items: widget.items.map(
        (value) {
          return DropdownMenuItem<DropdownItem>(
            value: value,
            child: Text(value.title ?? value.key),
          );
        },
      ).toList(),
      value: initialValue,
    );

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: sizeMS,
      ),
      margin: const EdgeInsets.symmetric(horizontal: sizeM, vertical: sizeS),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(borderRadiusValue)),
      child: dropdown,
    );
  }
}
