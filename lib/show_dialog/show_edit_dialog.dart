import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/show_dialog/show_edit_dialog.dart';
import 'package:proxy_provider_for_filter/utils/entity_input_data.dart';
import 'package:proxy_provider_for_filter/widget/base_widget/basic_dialog.dart';

import '../entities/base_model_entity.dart';
import '../provider/base_provider.dart';
import '../utils/get_name_of_title.dart';
export 'package:provider/provider.dart';

void showEditDialog<BP extends BaseProvider>(
  BuildContext context, {
  required BaseModelEntity item,
}) {
  final baseProvider = context.read<BP>();
  final nameTitle = getNameOfTitle(baseProvider);

  var currentName = item.name;

  showDialog(
    context: context,
    builder: (context) {
      return BasicDialog(
        title: 'Detail Page',
        listWidget: [
          Text('Name of $nameTitle'),
          TextFormField(
            initialValue: currentName,
            onChanged: (value) {
              currentName = value;
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(width: 5),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final updatedEntity = entityInputData<BP>(
                id: item.id,
                name: currentName,
                isFavorite: item.isFavorite,
                statusDropdown: item.statusDropdown,
                typeDropdown: item.typeDropdown,
              );

              if (updatedEntity != null) {
                await baseProvider.updateData(context, updatedEntity);
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          )
        ],
      );
    },
  );
}
