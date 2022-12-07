import 'package:dartz/dartz.dart';
import 'package:ergonomic_office_chair_manager/core/business/use_case.dart';
import 'package:ergonomic_office_chair_manager/features/home/domain/entities/connection_done_entity.dart';

import '../../../../core/error/failure.dart';
import '../repositories/home_repository.dart';

class ConnectToDeviceUseCase
    implements
        UseCase<Future<Either<Failure, ConnectionDoneEntity>>,
            ConnectToDeviceUseCaseParameters> {
  final HomeRepository _repository;

  ConnectToDeviceUseCase({
    required HomeRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, ConnectionDoneEntity>> call(
    ConnectToDeviceUseCaseParameters params,
  ) {
    return _repository.connect(params.deviceId);
  }
}

class ConnectToDeviceUseCaseParameters extends UseCaseParameters {
  final String deviceId;

  ConnectToDeviceUseCaseParameters(this.deviceId);
}
