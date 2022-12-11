import 'package:meta/meta.dart';
import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_device_model.dart';

abstract class BluetoothConnectorInterface {
  @protected
  Stream<bool> get isConnectedStream;

  @nonVirtual
  Stream<bool> get isConnectedBroadcastStream {
    if (isConnectedStream.isBroadcast) {
      return isConnectedStream;
    }

    throw 'stream must be broadcast';
  }

  Future<bool> get isEnabled;

  Future<List<BluetoothDeviceModel>> getBluetoothDevices();

  Future<bool> connect(BluetoothDeviceModel bluetoothDevice);

  Future<bool> disconnect();

  void send(String message);
}
