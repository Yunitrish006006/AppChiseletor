import 'package:app_chiseletor/widgets/auth_button.dart';
import 'package:app_chiseletor/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); //  獲取當前主題

    return Scaffold(
      appBar: AppBar(
        actions: const [ThemeToggleButton(), AuthButton()],
        backgroundColor: theme.appBarTheme.backgroundColor, //  使用主題中的顏色
        foregroundColor: theme.appBarTheme.foregroundColor,
        title: Text(widget.title),
      ),
      backgroundColor: theme.scaffoldBackgroundColor, //  Scaffold 背景色
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: theme.textTheme.bodyLarge, //  使用主題中的文字樣式
            ),
            Text(
              '$_counter',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.primaryColor,
              ), //  使用主題中的文字樣式，並覆蓋顏色
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: theme.floatingActionButtonTheme.backgroundColor,
        foregroundColor: theme.floatingActionButtonTheme.foregroundColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
