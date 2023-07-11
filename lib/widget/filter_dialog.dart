import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/widget/filter_dialog.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';
export 'package:provider/provider.dart';

import '../entities/base_dropdown_return.dart';
import '../provider/base_provider.dart';
import '../provider/filter_provider.dart';
import '../theme/theme_value.dart';
import '../utils/get_name_of_title.dart';
import 'base_widget/form_page_title.dart';
import 'dropdown_field.dart';

Widget filterListDialog<BP extends BaseProvider>(BuildContext context) {
  final baseProvider = context.read<BP>();
  final filterProvider = context.read<FilterProvider>();
  final nameTitle = getNameOfTitle(baseProvider);
  final dropdownOption = baseProvider.processLoadDropdownData();

  return FutureBuilder<BaseDropdownReturn>(
    future: dropdownOption,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const SizedBox(
          height: 50,
          width: 50,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      final dataSnap = snapshot.data;
      if (snapshot.hasData && dataSnap != null) {
        return FilterDialogPage(
          nameTitle: nameTitle,
          onApply: () async {
            return baseProvider.initFilterData(context);
          },
          onReset: () async {
            return baseProvider.initData(context);
          },
          dropdonwOption: dataSnap,
          filterProvider: filterProvider,
        );
      }

      return const SizedBox(
        height: 25,
        child: Center(
          child: Text("Dropdown Data Tidak Ditemukan"),
        ),
      );
    },
  );
}

class FilterDialogPage extends StatefulWidget {
  final String nameTitle;
  final BaseDropdownReturn dropdonwOption;
  final Future<void> Function() onApply;
  final Future<void> Function() onReset;
  final FilterProvider filterProvider;
  const FilterDialogPage(
      {Key? key,
      required this.nameTitle,
      required this.dropdonwOption,
      required this.onApply,
      required this.filterProvider,
      required this.onReset})
      : super(key: key);

  @override
  State<FilterDialogPage> createState() => _FilterDialogPageState();
}

class _FilterDialogPageState extends State<FilterDialogPage> {
  final listFilterDate = [
    "Last Update - Start",
    '',
    "Last Update - End",
  ];

  bool? isFavoriteValue;
  late final TextEditingController startDateController;
  late final TextEditingController endDateController;

  @override
  void initState() {
    super.initState();
    final filterProvider = widget.filterProvider;
    isFavoriteValue = filterProvider.favorite;

    var startDateString = "";
    var endDateString = "";

    if (filterProvider.startDate != null) {
      startDateString = DateFormat("MMM dd, yyyy").format(filterProvider.startDate!);
    }

    if (filterProvider.endDate != null) {
      endDateString = DateFormat("MMM dd, yyyy").format(filterProvider.endDate!);
    }
    
    startDateController = TextEditingController(text: startDateString);
    endDateController = TextEditingController(text: endDateString);
  }

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filterProvider = widget.filterProvider;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormPageTitle("Filter ${widget.nameTitle}"),
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
                      groupValue: isFavoriteValue,
                      value: isFavorite,
                      onChanged: (_) {
                        setState(() {
                          isFavoriteValue = isFavorite;
                        });
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
            child: Text("Type of ${widget.nameTitle}"),
          ),
          DropdownField(
            items: widget.dropdonwOption.listType,
            onChange: (item) {
              filterProvider.type = item;
            },
            initialValue: filterProvider.type,
          ),
          Container(
            margin: const EdgeInsets.only(left: sizeM + sizeS, top: sizeS),
            child: const Text("Status"),
          ),
          DropdownField(
            items: widget.dropdonwOption.listStatus,
            onChange: (item) {
              filterProvider.status = item;
            },
            initialValue: filterProvider.status,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: DateTimePicker(
                    controller: startDateController,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    dateLabelText: 'Start Create Date',
                    onChanged: (val) {
                      filterProvider.startDate = DateTime.parse(val);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DateTimePicker(
                    controller: endDateController,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                    dateLabelText: 'End Create Date',
                    onChanged: (val) {
                      filterProvider.endDate = DateTime.parse(val)
                          .add(const Duration(days: 1))
                          .subtract(const Duration(microseconds: 1));
                    },
                  ),
                )
              ],
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
                      onPressed: () async {
                        filterProvider.onReset();
                        await widget.onReset();
                        Navigator.pop(context);
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
                      onPressed: () async {
                        await widget.onApply();
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      child: const Text("Apply"),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
