part of 'disconnect_device_cubit.dart';

class DisconnectDeviceInitialState with DisconnectDeviceStates {}

class DisconnectDeviceLoadingState
    with DisconnectDeviceStates, BottomContainerStates {
  @override
  List<DeviceEntity> get devices => [];

  @override
  BottomContainerStatesEnum get state => BottomContainerStatesEnum.loading;
}

class DisconnectionFailedState with DisconnectDeviceStates {
  final String message;

  DisconnectionFailedState({required this.message});
}

class DisconnectionSuccessState with DisconnectDeviceStates {}
