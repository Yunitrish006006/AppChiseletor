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
