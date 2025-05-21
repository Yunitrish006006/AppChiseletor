import 'package:app_chiseletor_example/l10n/app_localizations.dart';
import 'package:app_chiseletor_example/pages/demo_sub/page1.dart';
import 'package:app_chiseletor_example/pages/demo_sub/page2.dart';
import 'package:app_chiseletor_example/pages/demo_sub/page3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_chiseletor/theme/theme_manager.dart';

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
    // 獲取主題管理器
    final themeManager = Provider.of<ThemeManager>(context);

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          // 主題功能展示區域
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '主題功能展示',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                // 顯示當前主題模式
                Row(
                  children: [
                    const Text('當前主題模式: '),
                    Text(
                      _getThemeModeText(themeManager.themeMode(context)),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // 獲取當前主題按鈕
                ElevatedButton(
                  onPressed: () {
                    // 使用 getCurrent 獲取當前主題
                    final currentTheme = themeManager.getCurrent(context);
                    _showThemeInfo(context, '當前主題', currentTheme);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        themeManager.getCurrent(context).primaryColor,
                    foregroundColor:
                        themeManager.getCurrent(context).colorScheme.onPrimary,
                  ),
                  child: const Text('獲取當前主題 (getCurrent)'),
                ),
                const SizedBox(height: 8),
                // 獲取相反主題按鈕
                ElevatedButton(
                  onPressed: () {
                    // 使用 getReverse 獲取相反主題
                    final reverseTheme = themeManager.getReverse(context);
                    _showThemeInfo(context, '相反主題', reverseTheme);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        themeManager.getReverse(context).primaryColor,
                    foregroundColor:
                        themeManager.getReverse(context).colorScheme.onPrimary,
                  ),
                  child: const Text('獲取相反主題 (getReverse)'),
                )
              ],
            ),
          ),
          const Divider(),
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

  // 顯示主題信息對話框
  void _showThemeInfo(BuildContext context, String title, ThemeData theme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildThemeColorInfo('主要顏色 (primaryColor)', theme.primaryColor),
              _buildThemeColorInfo('背景顏色 (scaffoldBackgroundColor)',
                  theme.scaffoldBackgroundColor),
              _buildThemeColorInfo('卡片顏色 (cardColor)', theme.cardColor),
              Text('亮度: ${theme.brightness == Brightness.dark ? '深色' : '淺色'}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('關閉'),
          ),
        ],
      ),
    );
  }

  // 構建主題顏色信息展示
  Widget _buildThemeColorInfo(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            color: color,
            margin: const EdgeInsets.only(right: 8),
          ),
          Expanded(
            child: Text(
              '$label: ${_colorToHex(color)}',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // 將顏色轉換為十六進制字符串
  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }

  // 獲取主題模式的文字描述
  String _getThemeModeText(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return '系統模式 (${MediaQuery.of(context).platformBrightness == Brightness.dark ? '當前為深色' : '當前為淺色'})';
      case ThemeMode.light:
        return '淺色模式';
      case ThemeMode.dark:
        return '深色模式';
    }
  }
}
