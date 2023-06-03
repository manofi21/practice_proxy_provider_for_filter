import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/widget/filter_dialog.dart';

import '../provider/base_provider.dart';

class TabbarHobbyView<FP extends BaseProvider> extends StatefulWidget {
  const TabbarHobbyView({Key? key}) : super(key: key);

  @override
  State<TabbarHobbyView<FP>> createState() => _TabbarHobbyViewState<FP>();
}

class _TabbarHobbyViewState<FP extends BaseProvider>
    extends State<TabbarHobbyView<FP>> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) async {
      final _prov = context.read<FP>();
      await _prov.initData(context);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FP>(
      builder: (context, value, child) {
        return SingleChildScrollView(
          child: Column(
            children: value.getListValue
                .map(
                  (e) => Text(e.name),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
