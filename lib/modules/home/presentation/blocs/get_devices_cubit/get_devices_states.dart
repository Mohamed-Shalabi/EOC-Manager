part of 'get_devices_cubit.dart';

class GetDevicesIdleState with GetDevicesStates {
  @override
  List<DeviceEntity> get devices => [];

  @override
  BottomContainerStatesEnum get state => BottomContainerStatesEnum.idle;
}

class GetDevicesLoadingState with GetDevicesStates {
  @override
  List<DeviceEntity> get devices => [];

  @override
  BottomContainerStatesEnum get state => BottomContainerStatesEnum.loading;
}

class GetDevicesSuccessState with GetDevicesStates {
  @override
  List<DeviceEntity> get devices => _devices;

  final List<DeviceEntity> _devices;

  GetDevicesSuccessState({required List<DeviceEntity> devices}) : _devices = devices;

  @override
  BottomContainerStatesEnum get state =>
      BottomContainerStatesEnum.succeededGettingDevices;
}

class GetDevicesFailedState with GetDevicesStates {
  @override
  List<DeviceEntity> get devices => [];

  final String message;

  GetDevicesFailedState({required this.message});

  @override
  BottomContainerStatesEnum get state =>
      BottomContainerStatesEnum.failedGettingDevices;
}
