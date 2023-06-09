import 'package:flutter/material.dart';

import '../entities/dropdown_item.dart';
import '../widget/base_widget/bottom_sheet.dart';
import '../widget/filter_dialog.dart';

Future<void> showFilterSheet(BuildContext context) async {
  final resultStatusList = <DropdownItem>[];
  showBaseBottomSheet(
    currentcontext: context,
    padding: const EdgeInsets.all(0),
    builder: filterDialog(
      context,
      resultStatusList,
    ),
  );
}
