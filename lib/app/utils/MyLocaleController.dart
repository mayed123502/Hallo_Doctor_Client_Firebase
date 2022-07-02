import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/main.dart';

class MyLocaleController extends GetxController {
  static final langs = ['English', "Urdu", 'France', 'Default'];

  void changeLang(String codeLang) {
    print("done");
    if (codeLang == 'def') {
      Locale locale = Get.deviceLocale!;

      shaedpref.setString("curruntLang", Get.deviceLocale!.languageCode);

      Get.updateLocale(locale);
    } else {
      Locale locale = Locale(codeLang);
      shaedpref.setString("curruntLang", codeLang);
      Get.updateLocale(locale);
    }
  }
  // static final locales = [
  //   Locale('en', 'US'),
  //   Locale('ur', 'PK'),
  //   Locale('fr', null)
  // ];
  // void changeLocale(String lang) {
  //   print("done");

  //   final locale = _getLocaleFromLanguage(lang);
  //   shaedpref.setString("curruntLang", lang);
  //   print("done");
  //   Get.updateLocale(locale);
  // }

  // Locale _getLocaleFromLanguage(String lang) {
  //   int index = langs.indexOf(lang);
  //   return locales[index];
  // }
}
