part of 'connect_to_device_cubit.dart';

abstract class ConnectToDeviceStates {}

class ConnectToDeviceInitialState extends ConnectToDeviceStates {}

class ConnectToDeviceLoadingState extends ConnectToDeviceStates {}

class ConnectToDeviceSuccessState extends ConnectToDeviceStates {}

class ConnectToDeviceFailedState extends ConnectToDeviceStates {
  final String message;

  ConnectToDeviceFailedState({required this.message});
}
