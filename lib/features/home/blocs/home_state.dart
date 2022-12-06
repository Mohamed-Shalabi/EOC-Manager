part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeBlocInitialState extends HomeState {}

class HomeLastSessionGotState extends HomeState {
  final int height;

  HomeLastSessionGotState(this.height);
}

class HomeGetBluetoothDevicesLoadingState extends HomeState {}

class HomeGetBluetoothDevicesSuccessState extends HomeState {}

class HomeGetBluetoothDevicesFailedState extends HomeState {}

class BluetoothConnectingState extends HomeState {}

class BluetoothConnectionDoneState extends HomeState {}

class BluetoothConnectionFailedState extends HomeState {
  final String message;

  BluetoothConnectionFailedState({this.message = ''});

  bool get hasMessage => message.isNotEmpty;
}

class BluetoothConnectedStatusState extends HomeState {}

class BluetoothDisconnectedStatusState extends HomeState {}

class BluetoothSendDataLoadingState extends HomeState {}

class BluetoothSendDataDoneState extends HomeState {}

class BluetoothSendDataFailedState extends HomeState {
  BluetoothSendDataFailedState({required this.message});

  final String message;
}

class BluetoothDisconnectingState extends HomeState {}

class BluetoothDisconnectingSuccessfulState extends HomeState {}

class BluetoothDisconnectingFailedState extends HomeState {}
