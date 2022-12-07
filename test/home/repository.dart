import 'package:ergonomic_office_chair_manager/features/home/domain/repositories/home_repository.dart';

class TestHomeRepository implements HomeRepository {
  @override
  Future<bool> send(int chairHeight) {
    return Future.value(true);
  }
}
