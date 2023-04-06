import 'package:ergonomic_office_chair_manager/modules/home/domain/entities/device_entity.dart';
import 'package:flutter_stateful_bloc/flutter_stateful_bloc.dart';

mixin BottomContainerStates implements ContextState {
  BottomContainerStatesEnum get state;
  List<DeviceEntity> get devices;

  @override
  List<Type> get parentStates => [BottomContainerStates];
}

enum BottomContainerStatesEnum {
  idle,
  loading,
  connected,
  failedGettingDevices,
  succeededGettingDevices,
}

mixin MainButtonStates implements ContextState {
  MainButtonStatesEnum get mainButtonState;

  @override
  List<Type> get parentStates => [MainButtonStates];
}

enum MainButtonStatesEnum {
  dismissed,
  showingDevices,
  connected,
}
