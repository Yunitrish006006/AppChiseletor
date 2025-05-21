import 'package:app_chiseletor_example/l10n/app_localizations.dart';
import 'package:app_chiseletor_example/pages/demo_sub/page1.dart';
import 'package:app_chiseletor_example/pages/demo_sub/page2.dart';
import 'package:app_chiseletor_example/pages/demo_sub/page3.dart';
import 'package:flutter/material.dart';
import 'package:app_chiseletor/theme/theme_manager_singleton.dart';

class DemoContent extends StatefulWidget {
  const DemoContent({super.key});

  @override
  State<DemoContent> createState() => _DemoContentState();
}

class _DemoContentState extends State<DemoContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // 直接使用單例獲取主題管理器
  final themeManager = ThemeManagerSingleton.instance;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // 添加監聽器，當主題變更時更新 UI
    themeManager.addListener(_themeListener);
  }

  @override
  void dispose() {
    _tabController.dispose();
    // 移除監聽器，避免內存洩漏
    themeManager.removeListener(_themeListener);
    super.dispose();
  }

  // 主題變更監聽器
  void _themeListener() {
    if (mounted) {
      setState(() {
        // 主題已變更，更新 UI
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // 不需要再從 Provider 中獲取主題管理器

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
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
