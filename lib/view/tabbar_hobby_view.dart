import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/utils/on_update_favorite_entity.dart';
import 'package:proxy_provider_for_filter/widget/filter_dialog.dart';

import '../provider/base_provider.dart';
import '../utils/get_name_of_title.dart';
import '../widget/tile_list_card_widget.dart';

class TabbarHobbyView<BP extends BaseProvider> extends StatefulWidget {
  const TabbarHobbyView({Key? key}) : super(key: key);

  @override
  State<TabbarHobbyView<BP>> createState() => _TabbarHobbyViewState<BP>();
}

class _TabbarHobbyViewState<BP extends BaseProvider>
    extends State<TabbarHobbyView<BP>> {

  @override
  void didChangeDependencies() {
    final _prov = context.read<BP>();

    // For handle notifyListeners in initData.
    WidgetsBinding.instance.addPostFrameCallback((duration) async {
      _prov.initData(context);
      super.didChangeDependencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BP>(
      builder: (context, value, child) {
        if (value.loading) {
          return const SizedBox(
            height: 50,
            width: 50,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: value.getListValue
                .map(
                  (e) => TileListCardWidget(
                    nameOfTitle: getNameOfTitle(value),
                    baseModelEntity: e,
                    onFavorite: () async {
                      final changeFavValue = onUpdateFavoriteEntity<BP>(
                        inputModel: e,
                      );
                      if (changeFavValue != null) {
                        await value.updateData(context, changeFavValue);
                      }
                    },
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
