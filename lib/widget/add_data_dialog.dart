import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/widget/filter_dialog.dart';
export 'package:provider/provider.dart';

import '../entities/base_dropdown_return.dart';
import '../provider/base_provider.dart';
import '../utils/get_name_of_title.dart';
import 'base_widget/form_page_dialog.dart';

Widget addDataDialog<BP extends BaseProvider>(BuildContext context) {
  final baseProvider = context.read<BP>();
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
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 20),
          child: FormPageDialog<BP>(
            nameTitle: nameTitle,
            buttonUpdateTitle: "Add New",
            pageTitle: "Add Data Dialog",
            onSubmitValue: (dataEntity) async {
              return baseProvider.addData(context, dataEntity);
            },
            dropdonwOption: dataSnap,
          ),
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