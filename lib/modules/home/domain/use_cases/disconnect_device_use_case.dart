import 'package:dartz/dartz.dart';
import 'package:ergonomic_office_chair_manager/core/business/use_case.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/entities/connection_state_entity.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/entities/connection_state_entity.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/repositories/home_repository.dart';

import '../../../../core/error/failure.dart';

class DisconnectDeviceUseCase
    implements
        UseCase<Future<Either<Failure, ConnectionStateEntity>>,
            DisconnectDeviceUseCaseParameters> {
  final HomeRepository _repository;

  DisconnectDeviceUseCase({
    required HomeRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, ConnectionStateEntity>> call(
    DisconnectDeviceUseCaseParameters params,
  ) {
    return _repository.disconnect(params.deviceId);
  }
}

class DisconnectDeviceUseCaseParameters extends UseCaseParameters {
  final String deviceId;

  DisconnectDeviceUseCaseParameters(this.deviceId);
}
