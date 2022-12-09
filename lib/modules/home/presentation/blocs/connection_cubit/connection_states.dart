part of 'connection_cubit.dart';

@immutable
abstract class ConnectionStates {}

class ConnectionInitialState extends ConnectionStates {}

class ConnectionConnectingState extends ConnectionStates {}

class ConnectionConnectedState extends ConnectionStates {}

class ConnectionDisconnectedState extends ConnectionStates {}

class ConnectionGetDevicesSuccessState extends ConnectionStates {}

class ConnectionGetDevicesFailedState extends ConnectionStates {
  final String message;

  ConnectionGetDevicesFailedState({required this.message});
}

class ConnectionAlreadyConnectedState extends ConnectionStates {}

class ConnectionAlreadyNotConnectedState extends ConnectionStates {}

class ConnectionConnectingFailedState extends ConnectionStates {
  final String message;

  ConnectionConnectingFailedState({required this.message});
}

class ConnectionConnectingDoneState extends ConnectionStates {}

class DisconnectionFailedState extends ConnectionStates {
  final String message;

  DisconnectionFailedState({required this.message});
}

class DisconnectionSuccessState extends ConnectionStates {}
