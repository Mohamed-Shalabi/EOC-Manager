part of 'connection_cubit.dart';

@immutable
abstract class ConnectionStates {}

class ConnectionInitialState extends ConnectionStates {}

class ConnectionConnectingState extends ConnectionStates {}

class ConnectionConnectedState extends ConnectionStates {}

class ConnectionDisconnectedState extends ConnectionStates {}

class ConnectionGetDevicesSuccessState extends ConnectionStates {}

class ConnectionGetDevicesFailedState extends ConnectionStates {}

class ConnectionAlreadyConnectedState extends ConnectionStates {}

class ConnectionAlreadyNotConnectedState extends ConnectionStates {}

class ConnectionConnectingFailedState extends ConnectionStates {}

class ConnectionConnectingDoneState extends ConnectionStates {}

class DisconnectionFailedState extends ConnectionStates {}

class DisconnectionSuccessState extends ConnectionStates {}
