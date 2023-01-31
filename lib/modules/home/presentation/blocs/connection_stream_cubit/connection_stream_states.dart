part of 'connection_stream_cubit.dart';

@immutable
abstract class ConnectionStates extends Equatable {

  @override
  List<Object> get props => [];
}

class ConnectionInitialState extends ConnectionStates {}

class ConnectionConnectedState extends ConnectionStates {}

class ConnectionDisconnectedState extends ConnectionStates {}
