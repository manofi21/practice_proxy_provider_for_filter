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
    this.validator,
  }) : super(key: key);

  final String title;
  final DateTime? initialDate;
  final void Function(DateTime?) onDateTimeChange;
  final String? Function(DateTime?)? validator;

  @override
  State<FilterDateButton> createState() => _FilterDateButtonState();
}

class _FilterDateButtonState extends State<FilterDateButton> {
  String? dateString;
  
  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: sizeS, bottom: sizeS),
              child: Text(widget.title),
            ),
            DateFormField(
              useFormFieldContainer: true,
              title: '',
              useTrailingButton: false,
              firstDate: firstDate,
              lastDate: today,
              initialDate: widget.initialDate,
              suffixIcon: const Icon(
                Icons.keyboard_arrow_down,
              ),
              validator: widget.validator,
              onChanged: (value) {
                widget.onDateTimeChange(value);
              },
            )
          ],
        );
  }
}
