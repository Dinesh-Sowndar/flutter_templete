import 'dart:ui';
import 'package:flutter_templete/translation/languages/english.dart';
import 'package:flutter_templete/translation/languages/tamil.dart';
import 'package:get/get.dart';

class LocalizationService extends Translations {

  static const fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'ta_TA': ta,
      };

}