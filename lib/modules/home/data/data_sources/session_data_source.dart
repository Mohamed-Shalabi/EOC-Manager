import 'package:ergonomic_office_chair_manager/core/local/storage_key_value_saver.dart';

class SessionDataSource {
  final StorageKeyValueSaver _storageKeyValueSaver;

  SessionDataSource({required StorageKeyValueSaver storageKeyValueSaver})
      : _storageKeyValueSaver = storageKeyValueSaver;

  Future<bool> saveSession(int userHeightInCm) {
    return _storageKeyValueSaver.saveData<int>(
      key: StorageKeys.saveSessionKey,
      value: userHeightInCm,
    );
  }

  Future<int?> getSavedSession() {
    return _storageKeyValueSaver.getData<int>(
      key: StorageKeys.saveSessionKey,
    );
  }
}
