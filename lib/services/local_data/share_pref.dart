import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  static late SharedPreferences _pref;

  static init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({required String key, dynamic data}) async {
    if (data is bool) return _pref.setBool(key, data);
    if (data is int) return _pref.setInt(key, data);
    if (data is String) return _pref.setString(key, data);
    return _pref.setDouble(key, data);
  }

  static Future? getData({required String key}) async {
    if (_pref.containsKey(key)) return _pref.get(key);

    return null;
  }

  static Future<bool> removeKey(String key) async {
    return _pref.remove(key);
  }
}
