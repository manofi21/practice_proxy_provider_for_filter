import 'package:flutter/material.dart';

import '../theme/theme_value.dart';

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
  late TabController _tabController;
  var _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 5,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Dashboard View"),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              alignment: Alignment.center,
              child: TabBar(
                controller: _tabController,
                indicatorWeight: 3,
                isScrollable: true,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: const Color(disabledColorValue),
                tabs: tabTitleSales,
              ),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 113,
        ),
        child: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [],
        ),
      ),
    );
  }
}
