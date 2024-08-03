import 'package:shared_preferences/shared_preferences.dart';

import '../platform/custom_io.dart';

class UserPreferences {
  final CustomIo customIo;
  final SharedPreferences? sharedPreferences;

  UserPreferences(this.customIo, this.sharedPreferences);

  String get language {
    String lang = 'default';
    try {
      lang = sharedPreferences!.getString('language') ?? 'default';
    } catch (_) {}

    if (lang != 'default' &&
        lang != "" &&
        lang.length == 2 &&
        lang == lang.toLowerCase()) {
      return lang;
    }

    final systemLanguage = customIo.getLocaleName();

    return systemLanguage.substring(0, 2).toLowerCase();
  }

  void set language(String lang) {
    if (lang == 'default' || lang.length == 2) {
      sharedPreferences!.setString('language', lang.toLowerCase());
      return;
    }
    throw Exception('Bad preference format');
  }
}
