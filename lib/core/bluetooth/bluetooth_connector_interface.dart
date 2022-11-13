import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_device_model.dart';

abstract class BluetoothConnectorInterface {
  Stream<bool> get isConnectedStream;

  Future<List<BluetoothDeviceModel>> getBluetoothDevices();

  Future<bool> connect(BluetoothDeviceModel bluetoothDevice);

  Future<bool> disconnect(BluetoothDeviceModel bluetoothDevice);

  void send(String message);
}
