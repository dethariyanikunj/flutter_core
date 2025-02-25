import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static const String keyAuthToken = 'key_auth_token';
  static SharedPreferences? _sharedPreferences;

  Future init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  ///will clear all the data stored in preference
  void clearPreferencesData() async {
    _sharedPreferences!.clear();
  }

  Future setAuthToken(String value) {
    return _sharedPreferences!.setString(keyAuthToken, value);
  }

  String? getAuthToken() {
    if (_sharedPreferences?.containsKey(keyAuthToken) ?? false) {
      return _sharedPreferences?.getString(keyAuthToken);
    }
    return null;
  }
}
