import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../platform/custom_io.dart';

class UserPreferences {
  final CustomIo customIo;
  final SharedPreferences? sharedPreferences;

  UserPreferences(this.customIo, this.sharedPreferences);

  String get language {
    String jsonString = '{"language": "deafult"}';
    try {
      jsonString =
          sharedPreferences!.getString('language') ?? '{"language": "deafult"}';
      if (!jsonString.startsWith('{')) {
        jsonString = '{"language": "deafult"}';
      }
    } catch (_) {}

    final decodedLanguage = jsonDecode(jsonString) as Map<String, dynamic>;
    //final decodedString = jsonString.
    //it should use default device language in not found in preferences
    //but enable to change it and store in app preferences
    //if(sharedPreferences.language != 'default' && null && len!=2 && language contains UperCase) then this below
    if (decodedLanguage['language'] != 'default' &&
        decodedLanguage['language'] != "" &&
        decodedLanguage['language'].length == 2 &&
        decodedLanguage['language'] ==
            decodedLanguage['language'].toLowerCase()) {
      return decodedLanguage['language'];
    }
    final systemLanguage = customIo.getLocaleName();

    return systemLanguage.substring(0, 2).toLowerCase();
  }

  void set language(String lang) {
    sharedPreferences!.setString('language', lang.toLowerCase());
  }
}
