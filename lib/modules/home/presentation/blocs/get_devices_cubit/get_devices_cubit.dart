import 'package:flutter_stateful_bloc/flutter_stateful_bloc.dart';

import '../../../domain/entities/device_entity.dart';
import '../../../domain/use_cases/get_devices_use_case.dart';
import '../state_organizer.dart';
import '../../ui/multi_state_organizer.dart';

part 'get_devices_states.dart';

class GetDevicesCubit extends StatefulCubit<GetDevicesStates> {
  const GetDevicesCubit({
    required GetDevicesUseCase getDevicesUseCase,
  }) : _getDevicesUseCase = getDevicesUseCase;

  final GetDevicesUseCase _getDevicesUseCase;

  void getDevices() async {
    emit(GetDevicesLoadingState());
    final devicesResult = await _getDevicesUseCase();
    devicesResult.fold<void>(
      (failure) => emit(GetDevicesFailedState(message: failure.message)),
      (devices) => emit(GetDevicesSuccessState(devices: devices)),
    );
  }

  void resetState() {
    emit(GetDevicesIdleState());
  }
}
