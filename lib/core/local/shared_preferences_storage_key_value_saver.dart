import 'package:ergonomic_office_chair_manager/core/local/storage_key_value_saver.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorageKeyValueSaver extends StorageKeyValueSaver {
  final SharedPreferences _instance;

  SharedPreferencesStorageKeyValueSaver(this._instance);

  @override
  Future<bool> deleteValidData<Type>({required String key}) {
    return _instance.remove(key);
  }

  @override
  Future<Type?> getValidData<Type>({required String key}) async {
    return _instance.get(key) as Type;
  }

  @override
  Future<bool> saveValidData<Type>({required String key, required Type value}) {
    if (value is bool) {
      _instance.setBool(key, value);
    } else if (value is int) {
      _instance.setInt(key, value);
    } else if (value is double) {
      _instance.setDouble(key, value);
    } else if (value is String) {
      _instance.setString(key, value);
    } else if (value is List<String>) {
      _instance.setStringList(key, value);
    }

    throw 'Unsupported Type';
  }
}
