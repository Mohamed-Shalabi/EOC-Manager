part of 'disconnect_device_cubit.dart';

abstract class DisconnectDeviceStates {}

class DisconnectDeviceInitialState extends DisconnectDeviceStates {}

class DisconnectDeviceLoadingState extends DisconnectDeviceStates {}

class DisconnectionFailedState extends DisconnectDeviceStates {
  final String message;

  DisconnectionFailedState({required this.message});
}

class DisconnectionSuccessState extends DisconnectDeviceStates {}
