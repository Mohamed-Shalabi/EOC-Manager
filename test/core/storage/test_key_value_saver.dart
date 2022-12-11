import 'package:ergonomic_office_chair_manager/core/local/storage_key_value_saver.dart';

class TestKeyValueSaver extends StorageKeyValueSaver {
  @override
  Future<bool> deleteValidData<Type>({required String key}) async {
    return _storage.remove(key) != null;
  }

  @override
  Future<Type?> getValidData<Type>({required String key}) async {
    return _storage[key] as Type?;
  }

  @override
  Future<bool> saveValidData<Type>({
    required String key,
    required Type value,
  }) async {
    if (value == null) {
      return _storage.remove(key) != null;
    }

    _storage[key] = value;
    return true;
  }
}

final Map<String, Object> _storage = {};
