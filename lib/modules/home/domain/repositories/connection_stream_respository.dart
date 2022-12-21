import '../entities/connection_state_entity.dart';

abstract class ConnectionStreamRepository {
  Stream<ConnectionStateEntity> get connectionStateStream;
}
