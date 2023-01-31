import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/disconnect_device_use_case.dart';

part 'disconnect_device_states.dart';

class DisconnectDeviceCubit extends Cubit<DisconnectDeviceStates> {
  DisconnectDeviceCubit({
    required DisconnectDeviceUseCase disconnectDeviceUseCase,
  })  : _disconnectDeviceUseCase = disconnectDeviceUseCase,
        super(DisconnectDeviceInitialState());

  final DisconnectDeviceUseCase _disconnectDeviceUseCase;

  Future<void> disconnectDevice() async {
    emit(DisconnectDeviceLoadingState());

    final disconnectionResult = await _disconnectDeviceUseCase();

    disconnectionResult.fold<void>(
      (failure) => emit(DisconnectionFailedState(message: failure.message)),
      (_) => emit(DisconnectionSuccessState()),
    );
  }
}
