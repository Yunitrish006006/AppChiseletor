import 'package:app_chiseletor/l10n/app_chiselator_localizations.dart';
import 'package:app_chiseletor/l10n/locale_provider_singleton.dart';
import 'package:flutter/material.dart';

class LanguageToggleButtonSingleton extends StatelessWidget {
  const LanguageToggleButtonSingleton({super.key});

  // Convert Locale to a string representation for menu items
  String _getLocaleString(Locale locale) {
    if (locale.countryCode == null || locale.countryCode!.isEmpty) {
      return locale.languageCode;
    }
    return '${locale.languageCode}-${locale.countryCode}';
  }

  // Get display name for a language
  String _getLanguageDisplayName(String code, AppLocalizations l10n) {
    switch (code) {
      case 'en':
        return l10n.languageEnglish;
      case 'zh-TW':
        return l10n.languageChineseTraditional;
      case 'zh-CN':
      case 'zh':
        return l10n.languageChineseSimplified;
      case 'ja':
        return 'Japanese'; // Add more language names as needed
      default:
        return code;
    }
  }

  // Build menu items for all supported locales
  List<PopupMenuEntry<String>> _buildLanguageMenuItems(
    BuildContext context,
    List<Locale> supportedLocales,
    AppLocalizations l10n,
  ) {
    final List<PopupMenuEntry<String>> items = [];

    // Process all supported locales
    for (final locale in supportedLocales) {
      final localeString = _getLocaleString(locale);
      final displayName = _getLanguageDisplayName(localeString, l10n);

      items.add(
        PopupMenuItem<String>(
          value: localeString,
          child: Text(displayName),
        ),
      );
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // 使用單例模式獲取語言提供者
    final localeProvider = LocaleProviderSingleton.instance;

    // 使用AnimatedBuilder監聽語言變化
    return AnimatedBuilder(
      animation: localeProvider,
      builder: (context, child) {
        final currentLocale = localeProvider.locale;
        final supportedLocales = localeProvider.supportedLocales;

        return PopupMenuButton<String>(
          icon: const Icon(Icons.language),
          tooltip: l10n.switchLanguage,
          onSelected: (String value) {
            if (value != _getLocaleString(currentLocale)) {
              Locale newLocale;
              switch (value) {
                case 'zh-TW':
                  // Traditional Chinese
                  newLocale = const Locale('zh', 'TW');
                  break;
                case 'zh-CN':
                case 'zh':
                  // Simplified Chinese
                  newLocale = const Locale('zh');
                  break;
                case 'en':
                  newLocale = const Locale('en');
                  break;
                case 'ja':
                  newLocale = const Locale('ja');
                  break;
                default:
                  newLocale = const Locale('zh', 'TW');
              }
              localeProvider.setLocale(newLocale);
            }
          },
          itemBuilder: (BuildContext context) =>
              _buildLanguageMenuItems(context, supportedLocales, l10n),
        );
      },
    );
  }
}
