import 'package:shared_preferences/shared_preferences.dart';

import '../platform/custom_io.dart';

abstract class UserPreferences {
  Future<String> get language;
  set language(Future<String> lang);
}

class UserPreferencesImpl implements UserPreferences {
  final CustomIo customIo;
  final SharedPreferences sharedPreferences;

  UserPreferencesImpl(this.customIo, this.sharedPreferences);

  @override
  Future<String> get language {
    final systemLanguage = customIo.getLocaleName();
    //it should use default device language in not found in preferences
    //but enable to change it and store in app preferences
    //if(sharedPreferences.language != 'default' && null && len!=2 && language contains UperCase) then this below
    //return sharedPreferences.language;

    return Future.value(systemLanguage.substring(0, 2).toLowerCase());
  }

  @override
  set language(Future<String> lang) {
    // TODO: implement language
    throw UnimplementedError();
  }
}
