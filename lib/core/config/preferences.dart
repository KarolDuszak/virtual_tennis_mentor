abstract class UserPreferences {
  Future<String> get language;

  //it should use default device language in not found in preferences
  //but enable to change it and store in app preferences
}
