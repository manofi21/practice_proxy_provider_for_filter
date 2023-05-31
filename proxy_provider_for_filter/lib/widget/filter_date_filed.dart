import 'package:flutter/material.dart';

import '../theme/theme_value.dart';
import '../utils/format_date_time_function.dart';
import 'base_widget/date_form_field.dart';

class FilterDateButton extends StatefulWidget {
  const FilterDateButton({
    Key? key,
    required this.title,
    required this.initialDate,
    required this.onDateTimeChange,
  }) : super(key: key);

  final String title;
  final DateTime? initialDate;
  final void Function(DateTime?) onDateTimeChange;

  @override
  State<FilterDateButton> createState() => _FilterDateButtonState();
}

class _FilterDateButtonState extends State<FilterDateButton> {
  @override
  Widget build(BuildContext context) {
    String? dateString;
    var initialDate = widget.initialDate;
    if (initialDate != null) {
      dateString = formatDateTime(
          dateTime: initialDate,
          formatPattern: FormatPattern.shortDateFullYear);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: sizeS, bottom: sizeS),
          child: Text(widget.title),
        ),
        DateFormField(
          controller: TextEditingController(text: dateString),
          useFormFieldContainer: true,
          title: '',
          useTrailingButton: false,
          firstDate: firstDate,
          lastDate: today,
          initialDate: initialDate,
          suffixIcon: const Icon(
            Icons.keyboard_arrow_down,
          ),
          onChanged: (value) {
            setState(() {
              initialDate = value;
            });
            widget.onDateTimeChange(value);
          },
        )
      ],
    );
  }
}
