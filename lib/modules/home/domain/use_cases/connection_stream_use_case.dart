import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_connector_interface.dart';
import 'package:ergonomic_office_chair_manager/core/business/use_case.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/entities/connection_state_entity.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/entities/connection_state_entity.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/repositories/home_repository.dart';

class ConnectionStreamUseCase
    implements UseCase<Stream<ConnectionStateEntity>, ConnectionStreamUseCaseParameters> {
  final HomeRepository _repository;

  ConnectionStreamUseCase({
    required HomeRepository repository,
  }) : _repository = repository;

  @override
  Stream<ConnectionStateEntity> call([
    ConnectionStreamUseCaseParameters params =
        const ConnectionStreamUseCaseParameters(),
  ]) {
    return _repository.connectionStateStream;
  }
}

class ConnectionStreamUseCaseParameters extends UseCaseParameters {
  const ConnectionStreamUseCaseParameters() : super();
}
