import 'package:flutter/material.dart';

import '../../entities/base_dropdown_return.dart';
import '../../entities/base_model_entity.dart';
import '../../entities/dropdown_item.dart';
import '../../provider/base_provider.dart';
import '../../utils/entity_input_data.dart';
import '../favorite_tile_list.dart';
import 'form_page_title.dart';
import '../dropdown_field.dart';

class FormPageDialog<BP extends BaseProvider> extends StatefulWidget {
  final String nameTitle;
  final BaseDropdownReturn dropdonwOption;
  final Future<void> Function(BaseModelEntity getEntity) onSubmitValue;
  final BaseModelEntity? item;
  final String buttonUpdateTitle;
  final String pageTitle;
  final bool useFavoriteSection;

  const FormPageDialog({
    Key? key,
    required this.nameTitle,
    required this.onSubmitValue,
    required this.dropdonwOption,
    required this.buttonUpdateTitle,
    required this.pageTitle,
    this.item,
    this.useFavoriteSection = false,
  }) : super(key: key);

  @override
  State<FormPageDialog<BP>> createState() => _FormPageDialogState<BP>();
}

class _FormPageDialogState<BP extends BaseProvider>
    extends State<FormPageDialog<BP>> {
  String name = '';

  @override
  void initState() {
    super.initState();
    name = widget.item?.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    DropdownItem? type = widget.item?.typeDropdown;
    DropdownItem? status = widget.item?.statusDropdown;
    bool favorite = widget.item?.isFavorite ?? false;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormPageTitle(widget.pageTitle, padding: EdgeInsets.zero),
          const SizedBox(height: 20),
          Text("Name of ${widget.nameTitle}:"),
          TextFormField(
            initialValue: name,
            onChanged: (onChangeValue) {
              name = onChangeValue;
            },
          ),
          const SizedBox(height: 10),
          Text("Type of ${widget.nameTitle}"),
          DropdownField(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            items: widget.dropdonwOption.listType,
            initialValue: type,
            onChange: (onChangeItem) {
              type = onChangeItem;
            },
          ),
          const Text("Status"),
          DropdownField(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            items: widget.dropdonwOption.listStatus,
            initialValue: status,
            onChange: (item) {
              status = item;
            },
          ),
          const SizedBox(height: 5),
          if (widget.useFavoriteSection) ...{
            FavoriteTileList(
              favorite: favorite,
              onFavChange: (fav) {
                favorite = fav;
              },
            )
          },
          SizedBox(
            width: MediaQuery.of(context).size.width - 10,
            child: OutlinedButton(
              onPressed: () async {
                final getEntity = entityInputData<BP>(
                  id: widget.item?.id,
                  name: name,
                  typeDropdown: type ?? DropdownItem(key: ''),
                  statusDropdown: status ?? DropdownItem(key: ''),
                  isFavorite: favorite,
                );
                if (getEntity != null) {
                  await widget.onSubmitValue(getEntity);
                }
                Navigator.pop(context);
              },
              child: Text(widget.buttonUpdateTitle),
            ),
          ),
          const SizedBox(height: 15)
        ],
      ),
    );
  }
}
