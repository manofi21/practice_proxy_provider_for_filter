import 'package:flutter/material.dart';

import '../../theme/theme_value.dart';
import '../../utils/format_date_time_function.dart';

class DateFormField extends StatelessWidget {
  const DateFormField({
    Key? key,
    required this.controller,
    this.enabled = true,
    this.validator,
    this.useFormFieldContainer = false,
    this.title,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onChanged,
    this.hint,
    this.useTrailingButton = true,
    this.autovalidateMode,
    // this.formatPattern,
    this.errorStyle,
    this.suffixIcon,
  }) : super(key: key);

  final TextEditingController controller;

  final String? Function(String?)? validator;

  final bool useFormFieldContainer;

  final bool enabled;

  final String? title;

  final DateTime? initialDate;

  final DateTime? firstDate;

  final DateTime? lastDate;

  final void Function(DateTime? dateTime)? onChanged;

  final String? hint;

  final bool useTrailingButton;

  final AutovalidateMode? autovalidateMode;

  // final FormatPattern? formatPattern;

  final TextStyle? errorStyle;

  final Widget? suffixIcon;

  Future<void> _onDateChanged(BuildContext context) async {
    final firstDate = this.firstDate ??
        DateTime.now().subtract(
          const Duration(days: 90),
        );
    final lastDate = this.lastDate ??
        DateTime.now().add(
          const Duration(days: 90),
        );

    final currentSelectedDate = initialDate ?? DateTime.now();

    final dateTime = await showDatePicker(
      context: context,
      initialDate: currentSelectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (dateTime != null) {
      controller.text = formatDateTimeStandart(
        dateTime: dateTime,
        onlyDate: true,
      );
    }

    final onChanged = this.onChanged;
    if (onChanged != null) {
      onChanged(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormField = TextFormField(
      controller: controller,
      autovalidateMode: autovalidateMode,
      showCursor: false,
      readOnly: true,
      enabled: enabled,
      onTap: () => _onDateChanged(context),
      validator: validator,
      decoration: InputDecoration(
        hintText: hint ?? "Please Select",
        contentPadding: formDefaultPadding,
        suffixIcon: suffixIcon,
        errorStyle: errorStyle ??
            TextStyle(
              color: Theme.of(context).colorScheme.error, // or any other color
            ),
      ),
    );

    return dateFormField;
  }
}
