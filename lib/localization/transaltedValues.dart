import 'package:flutter/material.dart';
import 'package:kutchmahamandalbhav/localization/demoLocalizations.dart';

class TransaltedValues {
  static String getTransaltedValues(BuildContext context, String key) {
    return DemoLocalizations.of(context).getTranslatedValue(key);
  }
}
