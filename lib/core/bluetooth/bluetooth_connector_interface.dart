import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_device_model.dart';
import 'package:meta/meta.dart';

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

  @nonVirtual
  Future<bool> get isEnabled async {
    try {
      return isEnabledOverridden;
    } catch (_) {
      return false;
    }
  }

  @protected
  Future<bool> get isEnabledOverridden;

  Future<List<BluetoothDeviceModel>> getBluetoothDevices();

  Future<bool> connect(BluetoothDeviceModel bluetoothDevice);

  Future<bool> disconnect();

  void send(String message);
}
