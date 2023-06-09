import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/provider/gaming_provider.dart';
import 'package:proxy_provider_for_filter/view/tabbar_hobby_view.dart';

import '../bottom_sheet/show_bottom_sheet_add_data.dart';
import '../bottom_sheet/show_bottom_sheet_filter_list.dart';
import '../provider/reading_provider.dart';
import '../provider/watching_provider.dart';
import '../theme/theme_value.dart';
import '../utils/tablet_padding.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

const tabTitleSales = [
  Tab(text: "Watching"),
  Tab(text: "Reading"),
  Tab(text: "Gaming"),
];

class _DashboardViewState extends State<DashboardView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  var currentIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: tabTitleSales.length,
      vsync: this,
    );
    tabController.addListener(() {
      setState(() {
        currentIndex = tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final paddingHorizontal = getTabletPaddingM(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text("Dashboard View"),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              alignment: Alignment.center,
              child: TabBar(
                controller: tabController,
                indicatorWeight: 3,
                isScrollable: true,
                unselectedLabelColor: const Color(disabledColorValue),
                tabs: tabTitleSales,
              ),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: bottomButtonHeight),
              child: TabBarView(
                controller: tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  TabbarHobbyView<WatchingProvider>(),
                  TabbarHobbyView<ReadingProvider>(),
                  TabbarHobbyView<GamingProvider>(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(), // Remove border radius
                child: SafeArea(
                  top: false, // Fix padding top of listButtons.
                  child: Container(
                    width: double.infinity,
                    height: bottomButtonHeight,
                    padding: EdgeInsets.symmetric(
                      vertical: sizeMS,
                      horizontal: paddingHorizontal,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              showBottomSheetAddData(
                                context,
                                index: currentIndex,
                              );
                            },
                            child: const Text("Create New"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              showBottomSheetFilterList(
                                context,
                                index: currentIndex,
                              );
                            },
                            child: const Text("Filter"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
