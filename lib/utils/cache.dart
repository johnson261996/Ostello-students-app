import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  Future<String?> getFromCache(String key) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.getString(key);
  }

  Future<void> addToCache(String key, String value) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString(key, value);
  }

  Future<void> clearCache() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.clear();
  }
}
