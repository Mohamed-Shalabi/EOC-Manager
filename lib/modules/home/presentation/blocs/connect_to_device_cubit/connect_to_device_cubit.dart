import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/connect_to_device_use_case.dart';

part 'connect_to_device_states.dart';

class ConnectToDeviceCubit extends Cubit<ConnectToDeviceStates> {
  ConnectToDeviceCubit({
    required ConnectToDeviceUseCase connectToDeviceUseCase,
  })  : _connectToDeviceUseCase = connectToDeviceUseCase,
        super(ConnectToDeviceInitialState());

  final ConnectToDeviceUseCase _connectToDeviceUseCase;

  var isConnectionLoading = false;

  void connectToDevice(String deviceId) async {
    isConnectionLoading = true;
    emit(ConnectToDeviceLoadingState());

    final connectionResult = await _connectToDeviceUseCase(
      ConnectToDeviceUseCaseParameters(deviceId),
    );

    isConnectionLoading = false;

    connectionResult.fold<void>(
      (failure) => emit(ConnectToDeviceFailedState(message: failure.message)),
      (connectionStateEntity) => emit(ConnectToDeviceSuccessState()),
    );
  }
}
