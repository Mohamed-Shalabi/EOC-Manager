import '../../../../core/bluetooth/bluetooth_connector_interface.dart';
import '../../../../core/bluetooth/bluetooth_device_model.dart';

class BluetoothDataSource {
  final BluetoothConnectorInterface _bluetoothConnector;
  late final Stream<bool> _isConnectedStream;
  var _bluetoothDevices = <BluetoothDeviceModel>[];
  BluetoothDeviceModel? _connectedDevice;

  BluetoothDataSource({
    required BluetoothConnectorInterface bluetoothConnector,
  }) : _bluetoothConnector = bluetoothConnector {
    _isConnectedStream = _bluetoothConnector.isConnectedBroadcastStream;
  }

  Future<bool> get isEnabled => _bluetoothConnector.isEnabled;

  Stream<bool> get isConnectedStream => _isConnectedStream;

  List<BluetoothDeviceModel> get bluetoothDevices => _bluetoothDevices;

  BluetoothDeviceModel? get connectedDevice => _connectedDevice;

  Future<List<BluetoothDeviceModel>> getBluetoothDevices() async {
    _bluetoothDevices = await _bluetoothConnector.getBluetoothDevices();
    return _bluetoothDevices;
  }

  Future<bool> connect(String deviceId) async {
    final bluetoothDevice =
        _bluetoothDevices.firstWhere((element) => element.address == deviceId);
    final isConnected = await _bluetoothConnector.connect(bluetoothDevice);
    if (isConnected) {
      _connectedDevice = bluetoothDevice;
    }

    return isConnected;
  }

  void send(int chairHeight) {
    _bluetoothConnector.send('$chairHeight');
  }

  Future<bool> disconnect() => _bluetoothConnector.disconnect();
}
