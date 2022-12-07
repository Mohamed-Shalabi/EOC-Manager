import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_connector_interface.dart';
import 'package:ergonomic_office_chair_manager/core/business/use_case.dart';

class ConnectionStreamUseCase
    implements UseCase<Stream<bool>, ConnectionStreamUseCaseParameters> {
  final BluetoothConnectorInterface _bluetoothConnector;

  ConnectionStreamUseCase({
    required BluetoothConnectorInterface bluetoothConnector,
  }) : _bluetoothConnector = bluetoothConnector;

  @override
  Stream<bool> call(ConnectionStreamUseCaseParameters params) {
    return _bluetoothConnector.isConnectedBroadcastStream;
  }
}

class ConnectionStreamUseCaseParameters extends UseCaseParameters {}
