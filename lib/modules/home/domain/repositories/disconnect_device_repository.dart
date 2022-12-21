import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class DisconnectDeviceRepository {
  Future<Either<Failure, void>> disconnect();
}
