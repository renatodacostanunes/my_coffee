import 'package:shared_preferences/shared_preferences.dart';

import '../istorage.dart';
import '../tools.dart';

class SharedPrefs extends IStorage {
  @override
  Future<void> save(String key, Object? value) async {
    if (key.isEmpty) return;
    if (value == null) {
      await delete(key);
    } else {
      try {
        final sharedPrefs = await SharedPreferences.getInstance();
        switch (value.runtimeType.toString()) {
          case "String":
          case "String?":
            await sharedPrefs.setString(key, value as String);
            break;
          case "int":
          case "int?":
            await sharedPrefs.setInt(key, value as int);
            break;
          case "double":
          case "double?":
            await sharedPrefs.setDouble(key, value as double);
            break;
          case "bool":
          case "bool?":
            await sharedPrefs.setBool(key, value as bool);
            break;
          case "List<String>":
          case "List<String>?":
            await sharedPrefs.setStringList(key, value as List<String>);
            break;
          default:
            throw Exception("Unsupported value type for $key");
        }
      } catch (e, stk) {
        logger(e, stk);
      }
    }
  }

  @override
  Future<T?> load<T>(String key) async {
    if (key.isEmpty) return null;
    final sharedPrefs = await SharedPreferences.getInstance();
    try {
      switch (T.toString()) {
        case "String":
        case "String?":
          return (sharedPrefs.getString(key) as T?);
        case "int":
        case "int?":
          return (sharedPrefs.getInt(key) as T?);
        case "double":
        case "double?":
          return (sharedPrefs.getDouble(key) as T?);
        case "bool":
        case "bool?":
          return (sharedPrefs.getBool(key) as T?);
        case "List<String>":
        case "List<String>?":
          return (sharedPrefs.getStringList(key) as T?);
        default:
          throw Exception("Unsupported value type for $key");
      }
    } catch (e, stk) {
      logger(e, stk);
      return null;
    }
  }

  @override
  Future<void> delete(String key) async {
    if (key.isEmpty) return;
    try {
      final sharedPrefs = await SharedPreferences.getInstance();
      await sharedPrefs.remove(key);
    } catch (e, stk) {
      logger(e, stk);
    }
  }

  @override
  Future<void> clear() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.clear();
  }

  @override
  Future<bool> contains(String key) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.containsKey(key);
  }
}
