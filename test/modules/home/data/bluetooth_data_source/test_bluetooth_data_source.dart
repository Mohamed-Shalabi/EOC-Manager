import 'dart:async';

import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_connector_interface.dart';
import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_device_model.dart';
import 'package:ergonomic_office_chair_manager/modules/home/data/data_sources/bluetooth_data_source.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'test_bluetooth_data_source.mocks.dart';

@GenerateMocks([BluetoothConnectorInterface])
void main() {
  group(
    'isEnabled',
    () {
      late BluetoothConnectorInterface bluetoothConnector;
      late BluetoothDataSource bluetoothDataSource;

      setUp(() {
        final streamController = StreamController<bool>();

        bluetoothConnector = MockBluetoothConnectorInterface();
        when(bluetoothConnector.isConnectedBroadcastStream).thenAnswer(
          (_) {
            return streamController.stream.asBroadcastStream();
          },
        );
        when(
          bluetoothConnector.connect(
            BluetoothDeviceModel(
              name: 'success',
              address: 'success_address',
            ),
          ),
        ).thenAnswer(
          (_) async {
            streamController.add(true);
            return true;
          },
        );
        when(
          bluetoothConnector.connect(
            BluetoothDeviceModel(
              name: 'failure',
              address: 'failure_address',
            ),
          ),
        ).thenAnswer(
          (_) async {
            streamController.add(false);
            return false;
          },
        );

        bluetoothDataSource = BluetoothDataSource(
          bluetoothConnector: bluetoothConnector,
        );
      });
      test(
        'isEnabled success',
        () async {
          when(bluetoothConnector.isEnabled).thenAnswer(
            (_) async => true,
          );

          expect(await bluetoothDataSource.isEnabled, true);
        },
      );
      test(
        'isEnabled failed',
        () async {
          when(bluetoothConnector.isEnabled).thenAnswer(
            (_) async => false,
          );

          expect(await bluetoothDataSource.isEnabled, false);
        },
      );
      test(
        'isConnectedStream success',
        () async {
          when(bluetoothConnector.getBluetoothDevices()).thenAnswer(
            (_) async {
              return [
                BluetoothDeviceModel(
                  name: 'success',
                  address: 'success_address',
                ),
                BluetoothDeviceModel(
                  name: 'failure',
                  address: 'failure_address',
                ),
              ];
            },
          );

          await bluetoothDataSource.getBluetoothDevices();

          final stream = bluetoothDataSource.isConnectedStream;

          expect(stream, emitsInOrder([true, false, true, false]));
          bluetoothDataSource.connect('success_address');
          bluetoothDataSource.connect('failure_address');
          bluetoothDataSource.connect('success_address');
          bluetoothDataSource.connect('failure_address');
        },
      );
      test(
        'getBluetoothDevices success',
        () async {
          when(bluetoothConnector.getBluetoothDevices()).thenAnswer(
            (_) async {
              return [
                BluetoothDeviceModel(name: 'test', address: 'test_address'),
                BluetoothDeviceModel(name: 'test2', address: 'test2_address'),
              ];
            },
          );

          final devices = await bluetoothConnector.getBluetoothDevices();
          expect(devices.isNotEmpty, true);
        },
      );
      test(
        'getBluetoothDevices fails',
        () async {
          const randomCode = '404';
          when(bluetoothConnector.getBluetoothDevices()).thenThrow(
            PlatformException(code: randomCode),
          );

          expect(
            () => bluetoothDataSource.getBluetoothDevices(),
            throwsA(const TypeMatcher<PlatformException>()),
          );
        },
      );
      test(
        'getBluetoothDevices fails',
        () async {
          const randomCode = '404';
          when(bluetoothConnector.getBluetoothDevices()).thenThrow(
            PlatformException(code: randomCode),
          );

          expect(
            () => bluetoothDataSource.getBluetoothDevices(),
            throwsA(const TypeMatcher<PlatformException>()),
          );
        },
      );
    },
  );
}
