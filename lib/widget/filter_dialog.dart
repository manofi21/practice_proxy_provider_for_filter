import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/widget/filter_dialog.dart';
export 'package:provider/provider.dart';

import '../entities/dropdown_item.dart';
import '../provider/filter_provider.dart';
import '../theme/theme_value.dart';
import 'base_widget/form_page_title.dart';
import 'dropdown_field.dart';
import 'filter_date_filed.dart';

Widget filterDialog(BuildContext context, List<DropdownItem> listStatus) {
  final filterProvider = context.watch<FilterProvider>();
  final listFilterDate = [
    "Last Update - Start",
    '',
    "Last Update - End",
  ];

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const FormPageTitle("Filter"),
      Container(
        margin: const EdgeInsets.only(left: sizeM),
        child: const Text("Favorite"),
      ),
      ...["Favorite", "Unfavorite"].map((label) {
        final isFavorite = label == "Favorite";

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: sizeS),
          child: InkWell(
            onTap: () {
              filterProvider.favorite = isFavorite;
            },
            borderRadius: BorderRadius.circular(sizeS),
            child: Row(
              children: [
                Radio<bool>(
                  groupValue: filterProvider.favorite,
                  value: isFavorite,
                  onChanged: (_) {
                    filterProvider.favorite = isFavorite;
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                Text(label)
              ],
            ),
          ),
        );
      }).toList(),
      Container(
        margin: const EdgeInsets.only(left: sizeM + sizeS, top: sizeS),
        child: const Text("Status"),
      ),
      DropdownField(
        items: listStatus,
        onChange: (item) {
          filterProvider.status = item;
        },
        initialValue: filterProvider.status,
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: sizeM),
        child: Column(
          children: listFilterDate.map((e) {
            if (e.isEmpty) {
              return const SizedBox(
                height: sizeM,
              );
            }

            if (e == "Last Update - Start") {
              return FilterDateButton(
                title: e,
                initialDate: filterProvider.startDate,
                onDateTimeChange: (selectedDate) {
                  filterProvider.startDate = selectedDate;
                },
              );
            }

            return FilterDateButton(
              title: e,
              initialDate: filterProvider.endDate,
              onDateTimeChange: (selectedDate) {
                filterProvider.endDate = selectedDate;
              },
            );
          }).toList(),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(sizeM),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: fieldHeight,
                child: OutlinedButton(
                  onPressed: () {
                    filterProvider.onReset();
                    Navigator.pop(context);
                    // pop(context: context);
                  },
                  child: const Text("Reset"),
                ),
              ),
            ),
            const SizedBox(
              width: sizeM,
            ),
            Expanded(
              child: SizedBox(
                height: fieldHeight + 2,
                child: ElevatedButton(
                  onPressed: () {
                    filterProvider.onUpdate();
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero)),
                  child: const Text("Apply"),
                ),
              ),
            )
          ],
        ),
      )
    ],
  );
}
