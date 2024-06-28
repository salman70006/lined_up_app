import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> setString(String key, String? value) async {
    SharedPreferences prefs = await _prefs;
    if (value != null && value.isNotEmpty) {
      prefs.setString(key, value);
    }
  }

  Future<String?> getString(String key) async {
    SharedPreferences prefs = await _prefs;
    return prefs.containsKey(key) ? prefs.getString(key) : "";
  }
  Future<String?> remove(String key,value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.remove(value);
    await prefs.clear();
  }

}