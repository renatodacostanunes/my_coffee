abstract class IStorage {
  Future<void> save(String key, Object? value);
  Future<T?> load<T>(String key);
  Future<void> delete(String key);
  Future<void> clear();
  Future<bool> contains(String key);
}
