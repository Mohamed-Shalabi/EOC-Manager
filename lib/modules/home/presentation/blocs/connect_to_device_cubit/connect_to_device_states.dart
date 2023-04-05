part of 'connect_to_device_cubit.dart';

class ConnectToDeviceInitialState with ConnectToDeviceStates {}

class ConnectToDeviceLoadingState
    with ConnectToDeviceStates, BottomContainerStates {
  @override
  BottomContainerStatesEnum get state => BottomContainerStatesEnum.loading;

  @override
  List<DeviceEntity> get devices => [];
}

class ConnectToDeviceSuccessState with ConnectToDeviceStates {}

class ConnectToDeviceFailedState with ConnectToDeviceStates {
  final String message;

  ConnectToDeviceFailedState({required this.message});
}
