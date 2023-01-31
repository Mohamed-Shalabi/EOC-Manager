import 'dart:async';

import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_connector_interface.dart';
import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_device_model.dart';

class FakeBluetoothConnector extends BluetoothConnectorInterface {
  final StreamController<bool> _streamController = StreamController();

  @override
  Future<bool> connect(BluetoothDeviceModel bluetoothDevice) {
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        _streamController.add(true);
        return true;
      },
    );
  }

  @override
  Future<bool> disconnect() {
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        _streamController.add(false);
        return true;
      },
    );
  }

  @override
  Future<List<BluetoothDeviceModel>> getBluetoothDevices() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => [
        BluetoothDeviceModel(name: 'name', address: 'address'),
        BluetoothDeviceModel(name: 'name', address: 'address'),
        BluetoothDeviceModel(name: 'name', address: 'address'),
        BluetoothDeviceModel(name: 'name', address: 'address'),
        BluetoothDeviceModel(name: 'name', address: 'address'),
      ],
    );
  }

  @override
  Stream<bool> get isConnectedStream {
    return _streamController.stream.asBroadcastStream();
  }

  @override
  Future<bool> get isEnabledOverridden async => true;

  @override
  void send(String message) {}
}
