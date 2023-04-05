import 'package:flutter_stateful_bloc/flutter_stateful_bloc.dart';

import '../../../domain/use_cases/connect_to_device_use_case.dart';
import '../state_organizer.dart';
import '../../ui/multi_state_organizer.dart';
import '../../../domain/entities/device_entity.dart';

part 'connect_to_device_states.dart';

class ConnectToDeviceCubit extends StatefulCubit<ConnectToDeviceStates> {
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
