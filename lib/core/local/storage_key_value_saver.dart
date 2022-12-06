import 'package:meta/meta.dart';

abstract class StorageKeyValueSaver {
  Future<bool> saveData<Type>({required String key, required Type value}) {
    _throwIfTypeNotSupported<Type>();
    return saveValidData(key: key, value: value);
  }

  Future<bool> deleteData<Type>({required String key}) {
    _throwIfTypeNotSupported<Type>();
    return deleteValidData(key: key);
  }

  Future<Type?> getData<Type>({required String key}) {
    _throwIfTypeNotSupported<Type>();
    return getValidData(key: key);
  }

  @protected
  Future<bool> saveValidData<Type>({required String key, required Type value});

  @protected
  Future<bool> deleteValidData<Type>({required String key});

  @protected
  Future<Type?> getValidData<Type>({required String key});
}

void _throwIfTypeNotSupported<Type>() {
  if (Type == dynamic) {
    throw 'Type must be specified';
  }
}
