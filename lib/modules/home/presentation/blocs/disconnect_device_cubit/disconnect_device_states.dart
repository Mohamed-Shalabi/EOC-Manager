part of 'disconnect_device_cubit.dart';

class DisconnectDeviceInitialState with DisconnectDeviceStates {}

class DisconnectDeviceLoadingState
    with DisconnectDeviceStates, BottomContainerLoadingState {
  @override
  Set<Type> get parentStates => {
        ...super.parentStates,
        BottomContainerLoadingState,
      };
}

class DisconnectionFailedState with DisconnectDeviceStates {
  final String message;

  DisconnectionFailedState({required this.message});
}

class DisconnectionSuccessState with DisconnectDeviceStates {}
