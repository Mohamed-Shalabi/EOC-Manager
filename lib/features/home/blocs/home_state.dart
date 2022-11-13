part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeBlocInitialState extends HomeState {}

class HomeGetBluetoothDevicesLoadingState extends HomeState {}

class HomeGetBluetoothDevicesSuccessState extends HomeState {}

class HomeGetBluetoothDevicesFailedState extends HomeState {}

class BluetoothConnectingState extends HomeState {}

class BluetoothConnectionDoneState extends HomeState {}

class BluetoothConnectionFailedState extends HomeState {}

class BluetoothConnectedStatusState extends HomeState {}

class BluetoothDisconnectedStatusState extends HomeState {}

class BluetoothSendDataLoadingState extends HomeState {}

class BluetoothSendDataDoneState extends HomeState {}

class BluetoothSendDataFailedState extends HomeState {
  BluetoothSendDataFailedState({required this.message});

  final String message;
}
