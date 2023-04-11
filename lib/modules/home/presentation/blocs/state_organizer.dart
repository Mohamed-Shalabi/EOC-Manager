import 'package:flutter_stateful_bloc/flutter_stateful_bloc.dart';

abstract class GetDevicesStates implements HomeStates {
  @override
  Set<Type> get parentStates => {
        HomeStates,
        GetDevicesStates,
      };
}

abstract class HomeStates implements ContextState {
  @override
  Set<Type> get parentStates => {HomeStates};
}

abstract class HomeAnimationsStates implements HomeStates {
  @override
  Set<Type> get parentStates => {
        HomeStates,
        HomeAnimationsStates,
      };
}

abstract class SendHeightStates implements HomeStates {
  @override
  Set<Type> get parentStates => {
        HomeStates,
        SendHeightStates,
      };
}

abstract class ConnectToDeviceStates implements HomeStates {
  @override
  Set<Type> get parentStates => {
        HomeStates,
        ConnectToDeviceStates,
      };
}

abstract class ConnectionBannerStates implements HomeStates {
  @override
  Set<Type> get parentStates => {
        HomeStates,
        ConnectionBannerStates,
      };
}

abstract class DisconnectDeviceStates implements HomeStates {
  @override
  Set<Type> get parentStates => {
        HomeStates,
        DisconnectDeviceStates,
      };
}

abstract class BottomContainerLoadingState implements HomeStates {
  @override
  Set<Type> get parentStates => {
        HomeStates,
        BottomContainerLoadingState,
      };
}

class BottomContainerLoadingStateInitial with BottomContainerLoadingState {}
