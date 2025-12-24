import 'package:shared_preferences/shared_preferences.dart';

class HiCache {
  static HiCache? _instance;
  SharedPreferences? _preferences;

  HiCache._();

  //预初始化，防止在使用get时，还未初始化完成
  static Future<HiCache> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = HiCache._pre(prefs);
    }
    return _instance!;
  }

  HiCache._pre(SharedPreferences prefs) {
    _preferences = prefs;
  }

  static HiCache getInstance() {
    return _instance ??= HiCache._();
  }

  void init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  void setString(String key, String value) {
    _preferences?.setString(key, value);
  }

  void setDouble(String key, double value) {
    _preferences?.setDouble(key, value);
  }
  
  void setInt(String key, int value) {
    _preferences?.setInt(key, value);
  }

  void setBool(String key, bool value) {
    _preferences?.setBool(key, value);
  }

  void setStringList(String key, List<String> value) {
    _preferences?.setStringList(key, value);
  }

  void clear() {
    _preferences?.clear();
  }

  T? get<T>(String key) {
    return _preferences?.get(key) as T?;
  }
}
