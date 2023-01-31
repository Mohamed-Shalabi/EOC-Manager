import 'package:dartz/dartz.dart';

import '../../../../core/business/use_case.dart';
import '../../../../core/error/failure.dart';
import '../repositories/connect_to_device_repository.dart';

class ConnectToDeviceUseCase
    implements
        UseCase<Future<Either<Failure, void>>,
            ConnectToDeviceUseCaseParameters> {
  final ConnectToDeviceRepository _repository;

  ConnectToDeviceUseCase({
    required ConnectToDeviceRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, void>> call(
    ConnectToDeviceUseCaseParameters params,
  ) async {
    final isEnabledResult = await _repository.isEnabled;
    final isDeviceEnabled = (isEnabledResult).isRight();
    if (!isDeviceEnabled) {
      return Left((isEnabledResult as Left<Failure, void>).value);
    }

    return _repository.connect(params.deviceId);
  }
}

class ConnectToDeviceUseCaseParameters extends UseCaseParameters {
  final String deviceId;

  ConnectToDeviceUseCaseParameters(this.deviceId);
}
