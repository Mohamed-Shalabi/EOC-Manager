import 'package:dartz/dartz.dart';
import 'package:ergonomic_office_chair_manager/core/business/use_case.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/entities/device_entity.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/repositories/home_repository.dart';

import '../../../../core/error/failure.dart';

class GetDevicesUseCase
    implements
        UseCase<Future<Either<Failure, List<DeviceEntity>>>,
            GetDevicesUseCaseParameters> {
  final HomeRepository _repository;

  GetDevicesUseCase({required HomeRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<DeviceEntity>>> call([
    GetDevicesUseCaseParameters params = const GetDevicesUseCaseParameters(),
  ]) async {
    final canConnect = await _repository.canConnect();
    if (canConnect.isLeft()) {
      return canConnect.map((r) => []);
    }

    return _repository.getDevices();
  }
}

class GetDevicesUseCaseParameters extends UseCaseParameters {
  const GetDevicesUseCaseParameters() : super();
}
