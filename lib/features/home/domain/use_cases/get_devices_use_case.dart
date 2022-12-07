import 'package:dartz/dartz.dart';
import 'package:ergonomic_office_chair_manager/core/business/use_case.dart';
import 'package:ergonomic_office_chair_manager/features/home/domain/entities/device_entity.dart';
import 'package:ergonomic_office_chair_manager/features/home/domain/repositories/home_repository.dart';

import '../../../../core/error/failure.dart';

class GetDevicesUseCase
    implements
        UseCase<Future<Either<Failure, List<DeviceEntity>>>,
            GetDevicesUseCaseParameters> {
  final HomeRepository repository;

  GetDevicesUseCase(this.repository);

  @override
  Future<Either<Failure, List<DeviceEntity>>> call(
      GetDevicesUseCaseParameters params) async {
    final canConnect = await repository.canConnect();
    if (canConnect.isLeft()) {
      throw 'Bluetooth is not open';
    }

    return repository.getDevices();
  }
}

class GetDevicesUseCaseParameters extends UseCaseParameters {}
