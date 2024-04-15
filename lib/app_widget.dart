import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_coffee/core/consts/size.dart';
import 'package:my_coffee/locale/language.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _AppWidgetState? state = context.findAncestorStateOfType<_AppWidgetState>();
    state?.setLocale(newLocale);
  }
}

class _AppWidgetState extends State<AppWidget> {
  Locale? _locale;

  @override
  void didChangeDependencies() {
    // TODO: Pega a localização do país do usuário.
    final Locale locale = View.of(context).platformDispatcher.locale;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    Language().getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  setLocale(Locale locale) => setState(() => _locale = locale);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: Modular.routerConfig,
      locale: _locale,
    );
  }
}
