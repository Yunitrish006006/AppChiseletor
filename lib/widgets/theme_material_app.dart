import 'package:app_chiseletor/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemedMaterialApp extends StatefulWidget {
  final Widget home;

  const ThemedMaterialApp({super.key, required this.home});

  @override
  State<ThemedMaterialApp> createState() => _ThemedMaterialAppState();
}

class _ThemedMaterialAppState extends State<ThemedMaterialApp> {
  @override
  void initState() {
    super.initState();
    //  在 initState 中訂閱 ThemeManager 的變化
    Provider.of<ThemeManager>(
      context,
      listen: false,
    ).addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    //  在 dispose 中取消訂閱
    Provider.of<ThemeManager>(
      context,
      listen: false,
    ).removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return MaterialApp(
      title: 'Flutter App',
      theme: themeManager.lightTheme(context),
      darkTheme: themeManager.darkTheme(context),
      themeMode: themeManager.themeMode(context),
      home: widget.home,
    );
  }
}
