import 'package:dartz/dartz.dart';
import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_device_model.dart';

import 'package:ergonomic_office_chair_manager/core/error/failure.dart';
import 'package:ergonomic_office_chair_manager/modules/home/data/data_sources/bluetooth_data_source.dart';
import 'package:ergonomic_office_chair_manager/modules/home/data/data_sources/ergonomic_heights_data_source.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/data_holders/device.dart';

import '../../domain/entities/connection_entity.dart';

class ConnectionEntityImpl implements ConnectionEntity {
  ConnectionEntityImpl(this._bluetoothDataSource);

  final BluetoothDataSource _bluetoothDataSource;

  @override
  bool canConnect(String deviceId) {
    return _bluetoothDataSource.bluetoothDevices
        .any((element) => element.address == deviceId);
  }

  @override
  Future<Either<Failure, Device>> connectToDevice(String deviceId) async {
    try {
      final device = await _bluetoothDataSource.connect(deviceId);

      if (device == null) {
        return Left(Failure(message: 'An error occurred'));
      }

      return Right(device.toDomain());
    } catch (e) {
      return Left(Failure(message: 'An error occurred'));
    }
  }

  @override
  Device? get currentConnectedDevice {
    return _bluetoothDataSource.connectedDevice?.toDomain();
  }

  @override
  Future<Either<Failure, void>> disconnectDevice() async {
    try {
      await _bluetoothDataSource.disconnect();

      return const Right(null);
    } catch (e) {
      return Left(Failure(message: 'An error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<Device>>> getDevices() async {
    try {
      final devices = await _bluetoothDataSource.getBluetoothDevices();

      return Right(devices.toDomain());
    } catch (e) {
      return Left(Failure(message: 'An error occurred'));
    }
  }

  @override
  bool get isConnected => _bluetoothDataSource.connectedDevice != null;

  @override
  Future<Either<Failure, void>> sendHeight(int userHeight) async {
    try {
      final netChairHeight =
          ErgonomicHeightsDataSource.of(userHeight).chairHeightInCm;

      _bluetoothDataSource.send(netChairHeight);

      return const Right(null);
    } on String catch (e) {
      return Left(Failure(message: e));
    } catch (e) {
      return Left(Failure(message: 'An error occurred'));
    }
  }
}

extension on BluetoothDeviceModel {
  Device toDomain() {
    return Device(
      id: address,
      name: name,
    );
  }
}

extension on List<BluetoothDeviceModel> {
  List<Device> toDomain() => map((e) => e.toDomain()).toList();
}
