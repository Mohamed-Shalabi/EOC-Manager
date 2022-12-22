import 'package:dartz/dartz.dart';

import '../../../../core/business/use_case.dart';
import '../../../../core/error/failure.dart';
import '../entities/device_entity.dart';
import '../repositories/get_devices_repository.dart';

class GetDevicesUseCase
    implements
        UseCase<Future<Either<Failure, List<DeviceEntity>>>,
            GetDevicesUseCaseParameters> {
  final GetDevicesRepository _repository;

  GetDevicesUseCase({required GetDevicesRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<DeviceEntity>>> call([
    GetDevicesUseCaseParameters params = const GetDevicesUseCaseParameters(),
  ]) async {
    final canConnect = await _repository.canConnect();
    if (canConnect.isLeft()) {
      return Left((canConnect as Left<Failure, void>).value);
    }

    return _repository.getDevices();
  }
}

class GetDevicesUseCaseParameters extends UseCaseParameters {
  const GetDevicesUseCaseParameters() : super();
}
