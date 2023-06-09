import 'package:flutter/material.dart';

import '../provider/gaming_provider.dart';
import '../provider/reading_provider.dart';
import '../provider/watching_provider.dart';
import '../widget/base_widget/bottom_sheet.dart';
import '../widget/filter_dialog.dart';

Future<void> showBottomSheetFilterList(
  BuildContext context, {
  required int index,
}) async {
  late Widget dialogWidget;
  if (index == 0) {
    dialogWidget = filterListDialog<WatchingProvider>(context);
  }

  if (index == 1) {
    dialogWidget = filterListDialog<ReadingProvider>(context);
  }

  if (index == 2) {
    dialogWidget = filterListDialog<GamingProvider>(context);
  }

  showBaseBottomSheet(
    currentcontext: context,
    padding: const EdgeInsets.all(0),
    builder: dialogWidget,
  );
}
