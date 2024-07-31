import '../platform/custom_io.dart';

abstract class UserPreferences {
  Future<String> get language;
}

class UserPreferencesImpl implements UserPreferences {
  final CustomIo customIo;

  UserPreferencesImpl(this.customIo);

  @override
  Future<String> get language {
    final systemLanguage = customIo.getLocaleName();
    //it should use default device language in not found in preferences
    //but enable to change it and store in app preferences
    return Future.value(systemLanguage.substring(0, 2).toLowerCase());
  }
}
