import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoLocalizations {
  //Locale Language
  final Locale locale;

  DemoLocalizations(this.locale);

  //All the language localized Values
  Map<String, String> _localizedValues;
  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  //Will Load the file from languageJson
  Future<void> load() async {
    String jsonStringValues = await rootBundle
        .loadString("lib/languages/${locale.languageCode}.json");
    //It will give string,dynamic
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    //Convert to string,string
    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  //Get Translated value
  String getTranslatedValue(String key) {
    return _localizedValues[key];
  }

  //Static Delegate of DemoLocalization
  static const LocalizationsDelegate<DemoLocalizations> delegate =
      _DemoLocalizationDelegate();
}

class _DemoLocalizationDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const _DemoLocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'gu'].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalizations> load(Locale locale) async {
    DemoLocalizations localizations = new DemoLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_DemoLocalizationDelegate old) => false;
}
