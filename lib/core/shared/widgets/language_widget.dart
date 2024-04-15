import 'package:flutter/material.dart';
import 'package:my_coffee/locale/language.dart';
import 'package:my_coffee/locale/language_entity.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<LanguageEntity>(
      underline: const SizedBox(),
      icon: const Icon(Icons.language),
      onChanged: (LanguageEntity? language) async {
        if (language != null) {
          Language().setLocale(context, language.languageCode);
        }
      },
      items: Language.languageList
          .map<DropdownMenuItem<LanguageEntity>>(
            (e) => DropdownMenuItem<LanguageEntity>(
              value: e,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    e.flag,
                    style: const TextStyle(fontSize: 30),
                  ),
                  Text(e.name)
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
