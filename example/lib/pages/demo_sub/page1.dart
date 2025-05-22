import 'package:app_chiseletor/theme/theme_manager_singleton.dart';
import 'package:app_chiseletor/widgets/clock.dart';
import 'package:app_chiseletor_example/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  bool _isVisible = true;
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeManager = ThemeManagerSingleton.instance;

    String getThemeModeText(ThemeMode mode) {
      switch (mode) {
        case ThemeMode.system:
          return '系統模式 (${MediaQuery.of(context).platformBrightness == Brightness.dark ? '當前為深色' : '當前為淺色'})';
        case ThemeMode.light:
          return '淺色模式';
        case ThemeMode.dark:
          return '深色模式';
      }
    }

    // 顯示主題信息對話框

    // 將顏色轉換為十六進制字符串
    String colorToHex(Color color) {
      return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
    }

    // 構建主題顏色信息展示
    Widget buildThemeColorInfo(String label, Color color) {
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
                '$label: ${colorToHex(color)}',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }

    void showThemeInfo(BuildContext context, String title, ThemeData theme) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildThemeColorInfo('主要顏色 (primaryColor)', theme.primaryColor),
                buildThemeColorInfo('背景顏色 (scaffoldBackgroundColor)',
                    theme.scaffoldBackgroundColor),
                buildThemeColorInfo('卡片顏色 (cardColor)', theme.cardColor),
                Text(
                    '亮度: ${theme.brightness == Brightness.dark ? '深色' : '淺色'}'),
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

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Card 展示
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    l10n.counter(_counter),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: Text(l10n.increment),
                  ),
                ],
              ),
            ),
          ),
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
                      getThemeModeText(themeManager.themeMode()),
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
                    showThemeInfo(context, '當前主題', currentTheme);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        themeManager.getCurrent(context).primaryColor,
                    foregroundColor:
                        themeManager.getCurrent(context).colorScheme.onPrimary,
                  ),
                  child: const Text('獲取當前主題 (getCurrent)'),
                ),
                const SizedBox(height: 8), // 獲取相反主題按鈕
                ElevatedButton(
                  onPressed: () {
                    // 使用 getReverse 獲取相反主題
                    final reverseTheme = themeManager.getReverse(context);
                    showThemeInfo(context, '相反主題', reverseTheme);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        themeManager.getReverse(context).primaryColor,
                    foregroundColor:
                        themeManager.getReverse(context).colorScheme.onPrimary,
                  ),
                  child: const Text('獲取相反主題 (getReverse)'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // AnimatedVisibility 展示
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            child: Text(l10n.toggleVisibility),
          ),
          AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(l10n.hiddenContent),
              ),
            ),
          ),
          const ClockWidget(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
