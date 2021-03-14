import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferences _sharedPreferences;

  addStringInSF(String key, String value) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString(key, value);
  }

  Future<String> getStringInSF(String key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String stringValue = _sharedPreferences.getString(key);
    return stringValue;
  }

  addIntInSF(String key, int value) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setInt(key, value);
  }

  Future<int> getIntInSF(String key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    int intValue = _sharedPreferences.getInt(key);
    return intValue;
  }

  addDoubleInSF(String key, double value) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setDouble(key, value);
  }

  Future<double> getDoubleInSF(String key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    double doubleValue = _sharedPreferences.getDouble(key);
    return doubleValue;
  }

  addBoolInPref(String key, bool value) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setBool(key, value);
  }

  Future<bool> getBoolInPref(String key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getBool(key);
  }

  Future<bool> removeValueFromSF(String key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    bool isRemoved = await _sharedPreferences.remove(key);
    return isRemoved;
  }

  checkValueFromSF(String key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    bool isRemoved = _sharedPreferences.containsKey(key);
    return isRemoved;
  }
}
