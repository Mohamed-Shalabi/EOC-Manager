import 'dart:async';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'bluetooth_connector_interface.dart';
import 'bluetooth_device_model.dart';
import '../functions/string_to_u_int_8_list.dart';

class FlutterSerialBluetoothConnector extends BluetoothConnectorInterface {
  late BluetoothConnection bluetoothConnector;
  final StreamController<bool> _isConnectedStreamController =
      StreamController<bool>();

  FlutterSerialBluetoothConnector() {
    Timer.periodic(
      const Duration(milliseconds: 300),
      (timer) {
        try {
          final isConnected = bluetoothConnector.isConnected;
          _isConnectedStreamController.add(isConnected);
        } catch (_) {
          _isConnectedStreamController.add(false);
        }
      },
    );
  }

  @override
  Stream<bool> get isConnectedStream {
    return _isConnectedStreamController.stream.asBroadcastStream();
  }

  @override
  Future<bool> get isEnabledOverridden async {
    return await FlutterBluetoothSerial.instance.isEnabled ?? false;
  }

  @override
  Future<bool> connect(BluetoothDeviceModel bluetoothDevice) async {
    try {
      bluetoothConnector = await BluetoothConnection.toAddress(
        bluetoothDevice.address,
      );
      return bluetoothConnector.isConnected;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> disconnect() async {
    try {
      await bluetoothConnector.finish();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<BluetoothDeviceModel>> getBluetoothDevices() async {
    final devices = await FlutterBluetoothSerial.instance.getBondedDevices();
    return devices
        .map(
          (e) => BluetoothDeviceModel(
            name: e.name ?? 'No Name',
            address: e.address,
          ),
        )
        .toList();
  }

  @override
  void send(String message) {
    bluetoothConnector.output.add(message.toUInt8List);
  }
}
