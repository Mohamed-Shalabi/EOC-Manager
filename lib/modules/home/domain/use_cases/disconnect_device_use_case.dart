import 'package:dartz/dartz.dart';

import '../../../../core/business/use_case.dart';
import '../../../../core/error/failure.dart';
import '../repositories/disconnect_device_repository.dart';

class DisconnectDeviceUseCase
    implements
        UseCase<Future<Either<Failure, void>>,
            DisconnectDeviceUseCaseParameters> {
  final DisconnectDeviceRepository _repository;

  DisconnectDeviceUseCase({
    required DisconnectDeviceRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, void>> call([
    DisconnectDeviceUseCaseParameters params =
        const DisconnectDeviceUseCaseParameters(),
  ]) {
    return _repository.disconnect();
  }
}

class DisconnectDeviceUseCaseParameters extends UseCaseParameters {
  const DisconnectDeviceUseCaseParameters() : super();
}
