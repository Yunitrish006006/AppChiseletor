import 'package:app_chiseletor/l10n/app_chiselator_localizations.dart';
import 'package:app_chiseletor/l10n/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        final currentLocale = localeProvider.locale;

        return PopupMenuButton<String>(
          icon: const Icon(Icons.language),
          tooltip: l10n.switchLanguage,
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
            PopupMenuItem<String>(
              value: 'en',
              child: Text(l10n.languageEnglish),
            ),
            PopupMenuItem<String>(
              value: 'zh',
              child: Text(l10n.languageChineseTraditional),
            ),
            PopupMenuItem<String>(
              value: 'zh-CN',
              child: Text(l10n.languageChineseSimplified),
            ),
          ],
        );
      },
    );
  }
}
