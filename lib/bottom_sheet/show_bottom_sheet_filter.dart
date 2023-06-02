import 'package:flutter/material.dart';

import '../entities/dropdown_item.dart';
import '../widget/base_widget/bottom_sheet.dart';
import '../widget/filter_dialog.dart';

Future<void> showFilterSheetSi(BuildContext context) async {
  final resultStatusListSi = <DropdownItem>[];
  Navigator.pop(context);

  showBaseBottomSheet(
    context: context,
    padding: const EdgeInsets.all(0),
    builder: (_) {
      return SalesSiFilterDialog(
        listStatus: resultStatusListSi,
      );
    },
  );
}
