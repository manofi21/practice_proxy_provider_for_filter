// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/entities/base_dropdown_return.dart';
import 'package:proxy_provider_for_filter/entities/base_model_entity.dart';
import 'package:proxy_provider_for_filter/entities/dropdown_item.dart';
import 'package:proxy_provider_for_filter/provider/base_provider.dart';
import 'package:proxy_provider_for_filter/theme/theme_value.dart';
import 'package:proxy_provider_for_filter/utils/entity_input_data.dart';
import 'package:proxy_provider_for_filter/utils/get_name_of_title.dart';
import 'package:proxy_provider_for_filter/widget/add_data_dialog.dart';
import 'package:proxy_provider_for_filter/widget/base_widget/form_page_title.dart';
import 'package:proxy_provider_for_filter/widget/dropdown_field.dart';
export 'package:provider/provider.dart';

/// NOTE: CARA INI AKAN MENYEBABKAN ERRO KARENA BUILDCONTEXT untuk PROVIDER BP
/// TIDAK DITEMUKAN. Harus ada BuildContext dari Parameter supanya context
/// nyambung dengan context sebelumnya.
/// 
/// 
/// Penggunaan dialihkan ke [addDataDialog]
@Deprecated('Use [addDataDialog] instead')
Widget _addDataDialog<BP extends BaseProvider>() {
  // final baseProvider = context.read<BP>();
  // final nameTitle = getNameOfTitle(baseProvider);
  // final dropdownOption = baseProvider.processLoadDropdownData();

  return FutureProvider<BaseDropdownReturn>(
    // value: dropdownOption,
    create: (futureContext) {
      final baseProvider = futureContext.read<BP>();
      final dropdownOption = baseProvider.processLoadDropdownData();
      return dropdownOption;
    },
    initialData: BaseDropdownReturn(
      listType: [],
      listStatus: [],
    ),
    builder: (futureContext, child) {
      final getDropdownValue = futureContext.read<BaseDropdownReturn>();
      final baseProvider = futureContext.read<BP>();

      final nameTitle = getNameOfTitle(baseProvider);
      return _AddDataDialogPage<BP>(
        nameTitle: nameTitle,
        onAddData: (dataEntity) async {
          baseProvider.addData(futureContext, dataEntity);
        },
        dropdonwOption: getDropdownValue,
      );
    },
  );
}

class _AddDataDialogPage<BP extends BaseProvider> extends StatefulWidget {
  final String nameTitle;
  final BaseDropdownReturn dropdonwOption;
  final Future<void> Function(BaseModelEntity getEntity) onAddData;
  const _AddDataDialogPage({
    Key? key,
    required this.nameTitle,
    required this.onAddData,
    required this.dropdonwOption,
  }) : super(key: key);

  @override
  State<_AddDataDialogPage<BP>> createState() => __AddDataDialogPageState<BP>();
}

class __AddDataDialogPageState<BP extends BaseProvider>
    extends State<_AddDataDialogPage<BP>> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    DropdownItem? type;
    DropdownItem? status;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FormPageTitle("Add Data Dialog"),
          Container(
            margin: const EdgeInsets.only(left: sizeM + sizeS, top: sizeS),
            child: Text("Name of ${widget.nameTitle}:"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23.0),
            child: TextFormField(
              controller: nameController,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: sizeM + sizeS, top: sizeS),
            child: Text("Type of ${widget.nameTitle}"),
          ),
          DropdownField(
            items: widget.dropdonwOption.listType,
            initialValue: type,
            onChange: (item) {
              setState(() {
                type = item;
              });
            },
          ),
          Container(
            margin: const EdgeInsets.only(left: sizeM + sizeS, top: sizeS),
            child: const Text("Status"),
          ),
          DropdownField(
            items: widget.dropdonwOption.listStatus,
            initialValue: status,
            onChange: (item) {
              status = item;
            },
          ),
          Container(
            margin: const EdgeInsets.all(sizeM),
            child: OutlinedButton(
              onPressed: () async {
                final getEntity = entityInputData<BP>(
                  name: nameController.text,
                  typeDropdown: type ?? DropdownItem(key: ''),
                  statusDropdown: status ?? DropdownItem(key: ''),
                  isFavorite: false,
                  createAt: DateTime.now(),
                );
                if (getEntity != null) {
                  await widget.onAddData(getEntity);
                }
                Navigator.pop(context);
              },
              child: const Text("Add Data"),
            ),
          )
        ],
      ),
    );
  }
}
