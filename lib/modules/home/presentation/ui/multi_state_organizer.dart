import 'package:ergonomic_office_chair_manager/modules/home/domain/entities/device_entity.dart';

import '../../../../stateful_bloc/stateful_bloc.dart';

mixin BottomContainerStates implements SuperState {
  BottomContainerStatesEnum get state;
  List<DeviceEntity> get devices;

  @override
  List<Type> get superStates => [BottomContainerStates];
}

enum BottomContainerStatesEnum {
  idle,
  loading,
  connected,
  failedGettingDevices,
  succeededGettingDevices,
}

mixin MainButtonStates implements SuperState {
  MainButtonStatesEnum get mainButtonState;

  @override
  List<Type> get superStates => [MainButtonStates];
}

enum MainButtonStatesEnum {
  dismissed,
  showingDevices,
  connected,
}
