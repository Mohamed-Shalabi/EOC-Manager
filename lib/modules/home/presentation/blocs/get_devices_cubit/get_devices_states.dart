part of 'get_devices_cubit.dart';

abstract class GetDevicesStates {}

class GetDevicesIdleState extends GetDevicesStates {}

class GetDevicesLoadingState extends GetDevicesStates {}

class GetDevicesSuccessState extends GetDevicesStates {
  final List<DeviceEntity> devices;

  GetDevicesSuccessState({required this.devices});
}

class GetDevicesFailedState extends GetDevicesStates {
  final String message;

  GetDevicesFailedState({required this.message});
}
