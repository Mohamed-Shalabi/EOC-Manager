part of 'connection_stream_cubit.dart';

class ConnectionBannerConnectedState with ConnectionBannerStates {
  @override
  BottomContainerStatesEnum get state => BottomContainerStatesEnum.connected;
}

class ConnectionBannerDisconnectedState with ConnectionBannerStates {
  final BottomContainerStates? lastState;

  ConnectionBannerDisconnectedState()
      : lastState = stateHolder.lastStateOfContextType(BottomContainerStates)
            as BottomContainerStates?;

  @override
  BottomContainerStatesEnum get state {
    return lastState is ConnectionBannerDisconnectedState || lastState == null
        ? BottomContainerStatesEnum.idle
        : lastState!.state;
  }
}
