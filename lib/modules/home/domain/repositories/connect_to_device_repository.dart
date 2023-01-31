import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/device_entity.dart';

abstract class ConnectToDeviceRepository {
  Future<Either<Failure, void>> get isEnabled;

  List<DeviceEntity> getDevices();

  Future<Either<Failure, void>> connect(String deviceId);
}
