import 'package:app_chiseletor/l10n/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        final currentLocale = localeProvider.locale;

        return PopupMenuButton<String>(
          icon: const Icon(Icons.language),
          onSelected: (String value) {
            if (value != currentLocale.toString()) {
              final newLocale = Locale(
                value == 'en' ? 'en' : 'zh',
                value == 'zh_TW' ? 'TW' : '',
              );
              localeProvider.setLocale(newLocale);
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'en',
              child: Text('English'),
            ),
            const PopupMenuItem<String>(
              value: 'zh',
              child: Text('中文'),
            ),
            const PopupMenuItem<String>(
              value: 'zh_TW',
              child: Text('繁體中文'),
            ),
          ],
        );
      },
    );
  }
}
