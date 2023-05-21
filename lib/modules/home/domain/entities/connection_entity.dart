import 'package:dartz/dartz.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/data_holders/device.dart';

import '../../../../core/error/failure.dart';

abstract class ConnectionEntity {
  bool get isConnected;

  Device? get currentConnectedDevice;

  bool canConnect(String deviceId);

  Future<Either<Failure, List<Device>>> getDevices();

  Future<Either<Failure, Device>> connectToDevice(String deviceId);

  Future<Either<Failure, void>> disconnectDevice();

  Future<Either<Failure, void>> sendHeight(int userHeight);
}
