import 'package:flutter/material.dart';

import '../../theme/theme_value.dart';

Future<Object?> showBottomSheet({
  required BuildContext context,
  required Widget Function(BuildContext context) builder,
  EdgeInsetsGeometry padding = const EdgeInsets.all(sizeL),
  bool isDismissible = true,
}) async {
  return showModalBottomSheet(
    context: context,
    elevation: 10,
    isScrollControlled: true,
    isDismissible: isDismissible,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(borderRadiusValue),
      ),
    ),
    builder: (context) {
      return Padding(
        padding: padding,
        child: builder(context),
      );
    },
  );
}
