import 'package:app_chiseletor_example/l10n/app_localizations.dart';
import 'package:app_chiseletor_example/pages/demo_sub/page1.dart';
import 'package:app_chiseletor_example/pages/demo_sub/page2.dart';
import 'package:app_chiseletor_example/pages/demo_sub/page3.dart';
import 'package:flutter/material.dart';

class DemoContent extends StatefulWidget {
  const DemoContent({super.key});

  @override
  State<DemoContent> createState() => _DemoContentState();
}

class _DemoContentState extends State<DemoContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          // TabBar 展示
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(icon: const Icon(Icons.directions_car), text: l10n.car),
              Tab(
                  icon: const Icon(Icons.directions_transit),
                  text: l10n.transit),
              Tab(icon: const Icon(Icons.directions_bike), text: l10n.bike),
            ],
          ),
          // TabBarView 展示
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                Page1(),
                Page2(),
                Page3(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
