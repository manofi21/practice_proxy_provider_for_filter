import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../entities/base_dropdown_return.dart';
import '../entities/base_model_entity.dart';
import '../provider/base_provider.dart';
import '../utils/get_name_of_title.dart';
import '../widget/base_widget/form_page_dialog.dart';
import 'package:provider/provider.dart';

void showEditDialog<BP extends BaseProvider>(
  BuildContext context, {
  required BaseModelEntity item,
}) {
  final baseProvider = context.read<BP>();
  final nameTitle = getNameOfTitle(baseProvider);
  final dropdownOption = baseProvider.processLoadDropdownData();

  showDialog(
    context: context,
    builder: (context) {
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
            final dateTimeFormat = DateFormat("EEEE, dd MMMM yyyy");

            final createAt = item.createAt;
            final updateAt = item.updateAt;
            return AlertDialog(
              content: FormPageDialog<BP>(
                nameTitle: nameTitle,
                buttonUpdateTitle: "Update",
                pageTitle: "Detail Dialog",
                onSubmitValue: (dataEntity) async {
                  return baseProvider.updateData(context, dataEntity);
                },
                dropdonwOption: dataSnap,
                item: item,
                children: [
                  if (createAt != null) ...{
                    Text(
                      'Created At : ${dateTimeFormat.format(createAt)}',
                    ),
                    const SizedBox(height: 10)
                  },
                  if (updateAt != null) ...{
                    Text(
                      'Update At : ${dateTimeFormat.format(updateAt)}',
                    ),
                    const SizedBox(height: 10)
                  },
                ],
                useFavoriteSection: true,
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
    },
  );
}
