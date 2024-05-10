import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_coffee/app_widget.dart';
import 'package:my_coffee/core/shared/utils/shared_prefs/shared_prefs.dart';

import 'language_entity.dart';

late final AppLocalizations lang;

/// Control the language
class Language {
  static const String language = 'languageCode';
  final _sharedPrefs = Modular.get<SharedPrefs>();

  /// Contains all available languages
  static const List<LanguageEntity> languageList = <LanguageEntity>[
    LanguageEntity(1, "🇺🇸", "English", "en"),
    LanguageEntity(2, "🇧🇷", "Português", "pt"),
  ];

  static const String en = 'en';
  static const String pt = 'pt';

  /// Configure the language and save the choice locally on the device
  Locale setLocale(
    BuildContext context,
    String languageCode,
  ) {
    () async {
      await _sharedPrefs.save(language, languageCode);
    }();
    AppWidget.setLocale(context, _locale(languageCode));
    return _locale(languageCode);
  }

  /// Get the saved language
  Future<Locale> getLocale() async {
    String languageCode = await _sharedPrefs.load<String>(language) ?? en;
    return _locale(languageCode);
  }

  Locale _locale(String languageCode) {
    switch (languageCode) {
      case en:
        return const Locale(en);
      case pt:
        return const Locale(pt);
      default:
        return const Locale(en);
    }
  }

  /// Reduces the size of the translated variable call
  AppLocalizations translation(BuildContext context) {
    return AppLocalizations.of(context)!;
  }
}
