import 'dart:async';

import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_connector_interface.dart';
import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_device_model.dart';

class BluetoothTestConnector extends BluetoothConnectorInterface {
  final _isConnectedStreamController = StreamController<bool>();

  @override
  Future<bool> connect(BluetoothDeviceModel bluetoothDevice) async {
    _isConnectedStreamController.add(true);
    return true;
  }

  @override
  Future<bool> disconnect() async {
    _isConnectedStreamController.add(false);
    return true;
  }

  @override
  Future<List<BluetoothDeviceModel>> getBluetoothDevices() async {
    return [
      for (int i = 0; i < 10; i++)
        BluetoothDeviceModel(name: 'device $i', address: 'address $i'),
    ];
  }

  @override
  Stream<bool> get isConnectedStream {
    return _isConnectedStreamController.stream.asBroadcastStream();
  }

  @override
  Future<bool> get isEnabled async => true;

  @override
  void send(String message) {}
}
