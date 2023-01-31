import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/device_entity.dart';

abstract class GetDevicesRepository {
  Future<Either<Failure, List<DeviceEntity>>> getDevices();

  Future<Either<Failure, void>> canConnect();
}
