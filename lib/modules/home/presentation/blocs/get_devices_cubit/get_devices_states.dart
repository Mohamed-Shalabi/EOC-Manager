part of 'get_devices_cubit.dart';

class GetDevicesIdleState with GetDevicesStates {}

class GetDevicesLoadingState
    with GetDevicesStates, BottomContainerLoadingState {}

class GetDevicesSuccessState with GetDevicesStates {
  List<DeviceEntity> get devices => _devices;

  final List<DeviceEntity> _devices;

  GetDevicesSuccessState({required List<DeviceEntity> devices})
      : _devices = devices;
}

class GetDevicesFailedState with GetDevicesStates {
  final String message;

  GetDevicesFailedState({required this.message});
}
