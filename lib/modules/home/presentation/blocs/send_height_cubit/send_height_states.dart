part of 'send_height_cubit.dart';

@immutable
abstract class SendHeightStates {}

class SendHeightInitialState extends SendHeightStates {}

class SendHeightSuccessState extends SendHeightStates {
  final String message;

  SendHeightSuccessState(this.message);
}

class SendHeightFailedState extends SendHeightStates {
  final String message;

  SendHeightFailedState({required this.message});
}
