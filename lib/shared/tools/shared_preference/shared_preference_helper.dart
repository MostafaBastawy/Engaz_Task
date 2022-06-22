import 'package:engaz_task/shared/tools/shared_preference/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static void sharedKeysDispose() {
    SharedPreferenceHelper.removeData(key: clickedPlace);
  }

  static Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is double) {
      return await sharedPreferences!.setDouble(key, value);
    }
    if (value is int) {
      return await sharedPreferences!.setInt(key, value);
    }
    if (value is String) {
      return await sharedPreferences!.setString(key, value);
    } else {
      return await sharedPreferences!.setBool(key, value);
    }
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences!.remove(key);
  }
}
