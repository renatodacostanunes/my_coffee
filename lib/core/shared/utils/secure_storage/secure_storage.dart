import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_coffee/core/shared/utils/tools.dart';

import '../istorage.dart';

class SecureStorage extends IStorage {
  // TODO: Adicionar logger...
  final _secureStorage = const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));

  @override
  Future<void> save(String key, Object? value) async {
    if (key.isEmpty) return;
    if (value == null) {
      await delete(key);
    } else {
      try {
        switch (value.runtimeType.toString()) {
          case "String":
          case "String?":
          case "int":
          case "int?":
          case "double":
          case "double?":
          case "bool":
          case "bool?":
            await _secureStorage.write(key: key, value: value.toString());
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
    try {
      final value = await _secureStorage.read(key: key);
      if (value == null) return null;
      switch (T.toString()) {
        case "String":
          return value as T;
        case "int":
          return int.parse(value) as T;
        case "double":
          return double.parse(value) as T;
        case "bool":
          return (value.toLowerCase() == "true") as T;
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
      await _secureStorage.delete(key: key);
    } catch (e, stk) {
      logger(e, stk);
    }
  }

  @override
  Future<void> clear() async {
    try {
      await _secureStorage.deleteAll();
    } catch (e, stk) {
      logger(e, stk);
    }
  }

  @override
  Future<bool> contains(String key) async {
    return await _secureStorage.containsKey(key: key);
  }
}
