import 'package:flutter/material.dart';

import '../../theme/theme_value.dart';
import '../../utils/tablet_padding.dart';

class FormPageTitle extends StatelessWidget {
  const FormPageTitle(
    this.title, {
    Key? key,
    this.textAlign = TextAlign.center,
    this.textStyle,
    this.padding,
  }) : super(key: key);

  final String title;
  final EdgeInsetsGeometry? padding;
  final TextAlign textAlign;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final paddingHorizontal = getTabletPaddingM(context);
    final padding = this.padding ??
        EdgeInsets.only(
          top: sizeM,
          bottom: sizeS,
          left: paddingHorizontal,
          right: paddingHorizontal,
        );

    return Padding(
      padding: padding,
      child: Text(
        title,
        textAlign: textAlign,
        style: textStyle ?? textTheme.titleLarge,
      ),
    );
  }
}
