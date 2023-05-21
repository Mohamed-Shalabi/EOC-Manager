import 'package:dartz/dartz.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/entities/connection_entity.dart';

import '../../../../core/business/use_case.dart';
import '../../../../core/error/failure.dart';

class DisconnectDeviceUseCase extends UseCase<Future<Either<Failure, void>>,
    DisconnectDeviceUseCaseParameters> {
  DisconnectDeviceUseCase(this._entity);

  final ConnectionEntity _entity;

  @override
  Future<Either<Failure, void>> call([
    DisconnectDeviceUseCaseParameters? params,
  ]) async {
    if (!_entity.isConnected) {
      return Left(
        Failure(message: 'You are already disconnected'),
      );
    }

    return _entity.disconnectDevice();
  }
}

class DisconnectDeviceUseCaseParameters extends UseCaseParameters {}
