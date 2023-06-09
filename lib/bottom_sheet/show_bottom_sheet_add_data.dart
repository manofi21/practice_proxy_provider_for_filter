import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/provider/watching_provider.dart';

import '../provider/gaming_provider.dart';
import '../provider/reading_provider.dart';
import '../widget/add_data_dialog.dart';
import '../widget/base_widget/bottom_sheet.dart';

Future<void> showBottomSheetAddData(
  BuildContext context, {
  required int index,
}) async {
  late Widget dialogWidget;
  if (index == 0) {
    dialogWidget = addDataDialog<WatchingProvider>(context);
  }

  if (index == 1) {
    dialogWidget = addDataDialog<ReadingProvider>(context);
  }

  if (index == 2) {
    dialogWidget = addDataDialog<GamingProvider>(context);
  }

  showBaseBottomSheet(
    currentcontext: context,
    padding: const EdgeInsets.all(0),
    builder: dialogWidget,
  );
}
