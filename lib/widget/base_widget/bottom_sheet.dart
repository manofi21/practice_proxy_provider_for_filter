import 'package:flutter/material.dart';

import '../../theme/theme_value.dart';

Future<Object?> showBaseBottomSheet({
  required BuildContext currentcontext,
  // required Widget Function(BuildContext context) builder,
  required Widget builder,
  EdgeInsetsGeometry padding = const EdgeInsets.all(sizeL),
  bool isDismissible = true,
}) async {
  return showModalBottomSheet(
    context: currentcontext,
    elevation: 10,
    isScrollControlled: true,
    isDismissible: isDismissible,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(borderRadiusValue),
      ),
    ),
    builder: (_) {
      return AnimatedPadding(
        padding: MediaQuery.of(currentcontext).viewInsets / 3.5,
        duration: const Duration(milliseconds: 100),
        curve: Curves.decelerate,
        child: Padding(
          padding: padding,
          child: builder,
        ),
      );
    },
  );
}
