import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_device_model.dart';
import 'package:ergonomic_office_chair_manager/modules/home/data/data_sources/bluetooth_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_injector.dart';

void main() {
  group(
    'Bluetooth data source test for the home module',
    () {
      late BluetoothDataSource bluetoothDataSource;
      late List<BluetoothDeviceModel> devices;
      TestInjector.init();
      setUp(() async {
        bluetoothDataSource = TestInjector.get<BluetoothDataSource>();

        devices = await bluetoothDataSource.getBluetoothDevices();
        expect(devices.isEmpty, false);
      });
      test(
        'isConnected Stream test',
        () async {
          final stream = bluetoothDataSource.isConnectedStream;
          expect(stream, emitsInOrder([true, false]));

          await bluetoothDataSource.connect(devices.first.address);
          await bluetoothDataSource.disconnect();
        },
      );
      test(
        'Bluetooth Connect test',
        () async {
          expect(await bluetoothDataSource.isEnabled, true);

          final isConnected = await bluetoothDataSource.connect(
            devices[0].address,
          );
          expect(isConnected, true);
        },
      );
      test(
        'Bluetooth Disconnect test',
        () async {
          expect(await bluetoothDataSource.isEnabled, true);

          final isDisconnected = await bluetoothDataSource.disconnect();
          expect(isDisconnected, true);
        },
      );
      test(
        'Bluetooth Send method test',
        () async {
          expect(await bluetoothDataSource.isEnabled, true);

          bluetoothDataSource.send(500);
        },
      );
    },
  );
}
