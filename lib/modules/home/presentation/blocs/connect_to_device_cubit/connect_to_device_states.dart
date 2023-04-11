part of 'connect_to_device_cubit.dart';

class ConnectToDeviceInitialState with ConnectToDeviceStates {}

class ConnectToDeviceLoadingState
    with ConnectToDeviceStates, BottomContainerLoadingState {
  @override
  Set<Type> get parentStates => {
        ...super.parentStates,
        BottomContainerLoadingState,
      };
}

class ConnectToDeviceSuccessState with ConnectToDeviceStates {}

class ConnectToDeviceFailedState with ConnectToDeviceStates {
  final String message;

  ConnectToDeviceFailedState({required this.message});
}
