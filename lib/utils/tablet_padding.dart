import 'package:flutter/material.dart';

import '../theme/theme_value.dart';


const _width = 600;
const _sizeAdd = 20;

double getTabletPaddingM(BuildContext context) {
  return getTabletPadding(context: context, size: sizeM);
}

double getTabletPaddingML(BuildContext context) {
  return getTabletPadding(context: context, size: sizeML);
}

double getTabletPadding({
  required BuildContext context,
  required double size,
}) {
  if (isTabletSize(context)) {
    return size + _sizeAdd;
  }
  return size;
}

bool isTabletSize(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  final deviceWidth = mediaQuery.size.width;
  return deviceWidth >= _width;
}
