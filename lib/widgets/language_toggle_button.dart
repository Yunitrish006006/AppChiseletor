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
          tooltip: '切換語言',
          onSelected: (String value) {
            if (value != currentLocale.toString()) {
              Locale newLocale;
              switch (value) {
                case 'zh':
                  // 選擇"中文"時，使用繁體中文
                  newLocale = const Locale('zh', 'TW');
                  break;
                case 'zh-CN':
                  // 簡體中文選項
                  newLocale = const Locale('zh');
                  break;
                case 'en':
                  newLocale = const Locale('en');
                  break;
                default:
                  newLocale = const Locale('zh', 'TW');
              }
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
              value: 'zh-CN',
              child: Text('简体中文'),
            ),
          ],
        );
      },
    );
  }
}
