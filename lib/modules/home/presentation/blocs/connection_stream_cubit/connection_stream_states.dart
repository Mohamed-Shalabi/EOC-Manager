part of 'connection_stream_cubit.dart';

@immutable
abstract class ConnectionStates {}

class ConnectionInitialState extends ConnectionStates {}

class ConnectionConnectedState extends ConnectionStates {}

class ConnectionDisconnectedState extends ConnectionStates {}
