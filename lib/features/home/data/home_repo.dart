import 'package:ergonomic_office_chair_manager/core/local/storage_key_value_saver.dart';

class HomeRepo {
  final StorageKeyValueSaver storageKeyValueSaver;

  HomeRepo(this.storageKeyValueSaver);

  Future<bool> saveSession(int userHeightInCm) {
    return storageKeyValueSaver.saveData<int>(
      key: 'key',
      value: userHeightInCm,
    );
  }

  Future<int?> getSavedSession() {
    return storageKeyValueSaver.getData<int>(key: 'key');
  }
}
