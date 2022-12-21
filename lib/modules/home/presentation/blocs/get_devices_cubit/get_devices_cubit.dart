import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/device_entity.dart';
import '../../../domain/use_cases/get_devices_use_case.dart';

part 'get_devices_states.dart';

class GetDevicesCubit extends Cubit<GetDevicesStates> {
  GetDevicesCubit({
    required GetDevicesUseCase getDevicesUseCase,
  })  : _getDevicesUseCase = getDevicesUseCase,
        super(GetDevicesInitialState());

  final GetDevicesUseCase _getDevicesUseCase;

  void getDevices() async {
    final devicesResult = await _getDevicesUseCase();
    devicesResult.fold<void>(
      (failure) => emit(GetDevicesFailedState(message: failure.message)),
      (devices) => emit(GetDevicesSuccessState(devices: devices)),
    );
  }
}
