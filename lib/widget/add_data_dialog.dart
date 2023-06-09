import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/widget/filter_dialog.dart';
export 'package:provider/provider.dart';

import '../entities/base_dropdown_return.dart';
import '../entities/base_model_entity.dart';
import '../entities/dropdown_item.dart';
import '../provider/base_provider.dart';
import '../theme/theme_value.dart';
import '../utils/entity_input_data.dart';
import '../utils/get_name_of_title.dart';
import 'base_widget/form_page_title.dart';
import 'dropdown_field.dart';

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
          child: CircularProgressIndicator(),
        );
      }

      final dataSnap = snapshot.data;
      if (snapshot.hasData && dataSnap != null) {
        return AddDataDialogPage<BP>(
          nameTitle: nameTitle,
          onAddData: (dataEntity) async {
            return baseProvider.addData(context, dataEntity);
          },
          dropdonwOption: dataSnap,
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

class AddDataDialogPage<BP extends BaseProvider> extends StatefulWidget {
  final String nameTitle;
  final BaseDropdownReturn dropdonwOption;
  final Future<void> Function(BaseModelEntity getEntity) onAddData;
  const AddDataDialogPage({
    Key? key,
    required this.nameTitle,
    required this.onAddData,
    required this.dropdonwOption,
  }) : super(key: key);

  @override
  State<AddDataDialogPage<BP>> createState() => _AddDataDialogPageState<BP>();
}

class _AddDataDialogPageState<BP extends BaseProvider>
    extends State<AddDataDialogPage<BP>> {
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
            onChange: (onChangeItem) {
              type = onChangeItem;
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
