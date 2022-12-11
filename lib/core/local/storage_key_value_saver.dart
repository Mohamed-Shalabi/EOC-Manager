import 'package:meta/meta.dart';

abstract class StorageKeyValueSaver {
  @nonVirtual
  Future<bool> saveData<Type>({required String key, required Type value}) {
    _throwIfTypeNotSupported<Type>();
    return saveValidData(key: key, value: value);
  }

  @nonVirtual
  Future<bool> deleteData<Type>({required String key}) {
    _throwIfTypeNotSupported<Type>();
    return deleteValidData(key: key);
  }

  @nonVirtual
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

abstract class StorageKeys {
  static const saveSessionKey = 'save_session';
}
