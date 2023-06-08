import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/widget/filter_dialog.dart';
export 'package:provider/provider.dart';

import '../entities/dropdown_item.dart';
import '../provider/base_provider.dart';
import '../theme/theme_value.dart';
import '../utils/entity_input_data.dart';
import '../utils/get_name_of_title.dart';
import 'base_widget/form_page_title.dart';
import 'dropdown_field.dart';

Widget addDataDialog<BP extends BaseProvider>(BuildContext context,
    {
    required List<DropdownItem> listType,
    required List<DropdownItem> listStatus}) {
  final baseProvider = context.read<BP>();
  final nameTitle = getNameOfTitle(baseProvider);
  String nameTitleDropdow = '';
  DropdownItem? type;
  DropdownItem? status;
  
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const FormPageTitle("Add Data Dialog"),
      Container(
        margin: const EdgeInsets.only(left: sizeM + sizeS, top: sizeS),
        child: Text("Name of $nameTitle:"),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23.0),
        child: TextFormField(
          onChanged: (value) {
            nameTitleDropdow = value;
          },
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: sizeM + sizeS, top: sizeS),
        child: Text("Type of $nameTitleDropdow"),
      ),
      DropdownField(
        items: listType,
        onChange: (item) {
          type = item;
        },
      ),
      Container(
        margin: const EdgeInsets.only(left: sizeM + sizeS, top: sizeS),
        child: const Text("Status"),
      ),
      DropdownField(
        items: listStatus,
        onChange: (item) {
          status = item;
        },
      ),
      Container(
        margin: const EdgeInsets.all(sizeM),
        child: OutlinedButton(
          onPressed: () async {
            final getEntity = entityInputData<BP>(
              name: nameTitle,
              typeDropdown: type ?? DropdownItem(key: ''),
              statusDropdown: status ?? DropdownItem(key: ''),
              isFavorite: false,
            );
            if (getEntity != null) {
              await baseProvider.addData(context, getEntity);
            }
            Navigator.pop(context);
          },
          child: const Text("Add Data"),
        ),
      )
    ],
  );
}
