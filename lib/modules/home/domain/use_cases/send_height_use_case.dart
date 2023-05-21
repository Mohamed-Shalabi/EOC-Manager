import 'package:dartz/dartz.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/entities/connection_entity.dart';

import '../../../../core/business/use_case.dart';
import '../../../../core/error/failure.dart';

class SendHeightUseCase extends UseCase<Future<Either<Failure, void>>,
    SendHeightUseCaseParameters> {
  SendHeightUseCase(this._entity);

  final ConnectionEntity _entity;

  @override
  Future<Either<Failure, void>> call(SendHeightUseCaseParameters params) async {
    if (!_entity.isConnected) {
      return Left(
        Failure(message: 'You are not connected yet.'),
      );
    }

    return _entity.sendHeight(params.userHeight);
  }
}

class SendHeightUseCaseParameters extends UseCaseParameters {
  final int userHeight;

  SendHeightUseCaseParameters(this.userHeight);
}
