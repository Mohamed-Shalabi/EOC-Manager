import 'package:ergonomic_office_chair_manager/modules/home/domain/entities/device_entity.dart';
import 'package:flutter_stateful_bloc/flutter_stateful_bloc.dart';

import '../../../domain/use_cases/disconnect_device_use_case.dart';
import '../state_organizer.dart';

part 'disconnect_device_states.dart';

class DisconnectDeviceCubit extends StatelessCubit<DisconnectDeviceStates> {
  const DisconnectDeviceCubit({
    required DisconnectDeviceUseCase disconnectDeviceUseCase,
  })  : _disconnectDeviceUseCase = disconnectDeviceUseCase;

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
