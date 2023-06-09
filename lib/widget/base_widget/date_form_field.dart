import 'package:flutter/material.dart';

import '../../theme/theme_value.dart';
import '../../utils/format_date_time_function.dart';

class DateFormField extends StatefulWidget {
  const DateFormField({
    Key? key,
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
    // this.formatPattern,
    this.errorStyle,
    this.suffixIcon,
  }) : super(key: key);

  final String? Function(DateTime?)? validator;

  final bool useFormFieldContainer;

  final bool enabled;

  final String? title;

  final DateTime? initialDate;

  final DateTime? firstDate;

  final DateTime? lastDate;

  final void Function(DateTime? dateTime)? onChanged;

  final String? hint;

  final bool useTrailingButton;


  // final FormatPattern? formatPattern;

  final TextStyle? errorStyle;

  final Widget? suffixIcon;

  @override
  State<DateFormField> createState() => _DateFormFieldState();
}

class _DateFormFieldState extends State<DateFormField> {
  late TextEditingController dateTextController;
  DateTime? currentSelectedDate;

  Future<void> _onDateChanged(BuildContext context) async {
    final firstDate = widget.firstDate ??
        DateTime.now().subtract(
          const Duration(days: 90),
        );
    final lastDate = widget.lastDate ??
        DateTime.now().add(
          const Duration(days: 90),
        );

    currentSelectedDate = currentSelectedDate ?? DateTime.now();

    final dateTime = await showDatePicker(
      context: context,
      initialDate: currentSelectedDate!,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (dateTime != null) {
      dateTextController.text = formatDateTimeStandart(
        dateTime: dateTime,
        onlyDate: true,
      );
    }

    final onChanged = widget.onChanged;
    currentSelectedDate = dateTime;
    if (onChanged != null) {
      onChanged(dateTime);
    }
  }

  @override
  void initState() {
    super.initState();
    final initialDate = widget.initialDate != null
        ? formatDateTimeStandart(dateTime: widget.initialDate!, onlyDate: true)
        : '';
    currentSelectedDate = widget.initialDate ?? DateTime.now();
    dateTextController = TextEditingController(text: initialDate);
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: false,
      enabled: true,
      builder: (FormFieldState<bool> field) {
        final dateFormField = TextFormField(
          controller: dateTextController,
          autovalidateMode: AutovalidateMode.always,
          showCursor: false,
          readOnly: true,
          enabled: widget.enabled,
          onTap: () async {
            await _onDateChanged(context);
            field.didChange(true);
          },
          validator: (_) => widget.validator != null ? widget.validator!(currentSelectedDate) : null,
          decoration: InputDecoration(
            hintText: widget.hint ?? "Please Select",
            contentPadding: formDefaultPadding,
            suffixIcon: widget.suffixIcon,
            errorStyle: widget.errorStyle ??
                TextStyle(
                  color:
                      Theme.of(context).colorScheme.error, // or any other color
                ),
          ),
        );

        return dateFormField;
      },
    );
  }
}
