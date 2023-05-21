import 'package:dartz/dartz.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/entities/connection_entity.dart';

import '../../../../core/business/use_case.dart';
import '../../../../core/error/failure.dart';
import '../data_holders/device.dart';

class ConnectToDeviceUseCase extends UseCase<Future<Either<Failure, Device>>,
    ConnectToDeviceUseCaseParameters> {
  ConnectToDeviceUseCase(this._entity);

  final ConnectionEntity _entity;

  @override
  Future<Either<Failure, Device>> call(
    ConnectToDeviceUseCaseParameters params,
  ) async {
    if (_entity.isConnected) {
      return Left(
        Failure(
          message: 'Disconnect the current device before '
              'trying to connect to another one',
        ),
      );
    }

    final bool canConnect = _entity.canConnect(params.deviceId);

    if (!canConnect) {
      return Left(Failure(message: 'Could not connect to device'));
    }

    return _entity.connectToDevice(params.deviceId);
  }
}

class ConnectToDeviceUseCaseParameters extends UseCaseParameters {
  final String deviceId;

  ConnectToDeviceUseCaseParameters(this.deviceId);
}
