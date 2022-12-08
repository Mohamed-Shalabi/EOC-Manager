import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_connector_interface.dart';

import '../../../../core/bluetooth/bluetooth_device_model.dart';

class BluetoothDataSource {
  final BluetoothConnectorInterface _bluetoothConnector;
  late final Stream<bool> _isConnectedStream;
  var bluetoothDevices = <BluetoothDeviceModel>[];

  BluetoothDataSource({
    required BluetoothConnectorInterface bluetoothConnector,
  }) : _bluetoothConnector = bluetoothConnector {
    _isConnectedStream = _bluetoothConnector.isConnectedBroadcastStream;
  }

  Future<bool> get isEnabled => _bluetoothConnector.isEnabled;

  Stream<bool> get isConnectedStream => _isConnectedStream;

  Future<List<BluetoothDeviceModel>> getBluetoothDevices() async {
    bluetoothDevices = await _bluetoothConnector.getBluetoothDevices();
    return bluetoothDevices;
  }

  Future<bool> connect(String deviceId) {
    final bluetoothDevice =
        bluetoothDevices.firstWhere((element) => element.address == deviceId);
    return _bluetoothConnector.connect(bluetoothDevice);
  }

  void send(int chairHeight) {
    _bluetoothConnector.send('$chairHeight');
  }

  Future<bool> disconnect() => _bluetoothConnector.disconnect();
}
