import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kutchmahamandalbhav/localization/transaltedValues.dart';
import 'package:kutchmahamandalbhav/main.dart';

enum Languages { gujarati, english }

class ChangeLanguagePage extends StatefulWidget {
  final String languageCode;
  ChangeLanguagePage({Key key, this.languageCode}) : super(key: key);

  static Route<ChangeLanguagePage> route(RouteSettings settings) {
    return CupertinoPageRoute(
        builder: (context) => ChangeLanguagePage(
              languageCode: settings.arguments,
            ));
  }

  @override
  _ChangeLanguagePageState createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  Languages languageEnum;

  @override
  void initState() {
    if (widget.languageCode == "gu") {
      languageEnum = Languages.gujarati;
    } else {
      languageEnum = Languages.english;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            TransaltedValues.getTransaltedValues(context, "change_language")),
      ),
      body: Column(
        children: [
          RadioListTile<Languages>(
              title: Text(
                  TransaltedValues.getTransaltedValues(context, "gujarati")), //
              value: Languages.gujarati,
              groupValue: languageEnum,
              onChanged: (value) {
                setState(() {
                  languageEnum = value;
                });
                MyApp.setLocale(context, Locale("gu", ''));
              }),
          RadioListTile<Languages>(
              title: Text(
                  TransaltedValues.getTransaltedValues(context, "english")), //
              value: Languages.english,
              groupValue: languageEnum,
              onChanged: (value) {
                setState(() {
                  languageEnum = value;
                });
                MyApp.setLocale(context, Locale("en", ''));
              }),
        ],
      ),
    );
  }
}
