import 'package:flutter_stateful_bloc/flutter_stateful_bloc.dart';

import '../../../domain/use_cases/connect_to_device_use_case.dart';
import '../state_organizer.dart';

part 'connect_to_device_states.dart';

class ConnectToDeviceCubit extends StatelessCubit<ConnectToDeviceStates> {
  const ConnectToDeviceCubit({
    required ConnectToDeviceUseCase connectToDeviceUseCase,
  })  : _connectToDeviceUseCase = connectToDeviceUseCase;

  final ConnectToDeviceUseCase _connectToDeviceUseCase;

  void connectToDevice(String deviceId) async {
    emit(ConnectToDeviceLoadingState());

    final connectionResult = await _connectToDeviceUseCase(
      ConnectToDeviceUseCaseParameters(deviceId),
    );

    connectionResult.fold<void>(
      (failure) => emit(ConnectToDeviceFailedState(message: failure.message)),
      (connectionStateEntity) => emit(ConnectToDeviceSuccessState()),
    );
  }
}
