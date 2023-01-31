import '../../../../core/business/use_case.dart';
import '../entities/connection_state_entity.dart';
import '../repositories/connection_stream_respository.dart';

class ConnectionStreamUseCase
    implements
        UseCase<Stream<ConnectionStateEntity>,
            ConnectionStreamUseCaseParameters> {
  final ConnectionStreamRepository _repository;

  ConnectionStreamUseCase({
    required ConnectionStreamRepository repository,
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
