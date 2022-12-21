import '../../domain/entities/connection_state_entity.dart';
import '../../domain/repositories/connection_stream_respository.dart';
import '../data_sources/bluetooth_data_source.dart';

class ConnectionStreamRepositoryImpl implements ConnectionStreamRepository {
  final BluetoothDataSource _bluetoothDataSource;

  ConnectionStreamRepositoryImpl({
    required BluetoothDataSource bluetoothDataSource,
  }) : _bluetoothDataSource = bluetoothDataSource;

  @override
  Stream<ConnectionStateEntity> get connectionStateStream {
    return _bluetoothDataSource.isConnectedStream.map(
      (isConnected) => isConnected
          ? ConnectionStateEntity.connected()
          : ConnectionStateEntity.disconnected(),
    );
  }
}
