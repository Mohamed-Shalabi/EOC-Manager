part of 'send_height_cubit.dart';

@immutable
abstract class SendHeightStates {}

class SendHeightInitialState extends SendHeightStates {}

class SendHeightSuccessState extends SendHeightStates {}

class SendHeightFailedState extends SendHeightStates {}
