import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_connector_interface.dart';
import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_device_model.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class FlutterBluetoothSerialConnector implements BluetoothConnectorInterface {
  late BluetoothConnection bluetoothConnector;
  final StreamController<BluetoothState> _connectionStatusStreamController =
      StreamController<BluetoothState>();

  FlutterBluetoothSerialConnector() {
    FlutterBluetoothSerial.instance.onStateChanged().listen((event) {
      _connectionStatusStreamController.add(event);
    });
  }

  @override
  Stream<bool> get isConnectedStream {
    return _connectionStatusStreamController.stream.map(
      (event) => event.isEnabled,
    );
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
  Future<bool> disconnect(BluetoothDeviceModel bluetoothDevice) async {
    try {
      await bluetoothConnector.finish();
      return true;
    } catch (e, s) {
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
    final uint8List = Uint8List.fromList(utf8.encode(message));
    bluetoothConnector.output.add(uint8List);
  }
}
