import 'package:flutter_stateful_bloc/flutter_stateful_bloc.dart';

import '../../domain/entities/device_entity.dart';
import '../ui/multi_state_organizer.dart';

abstract class GetDevicesStates implements HomeStates, BottomContainerStates {
  @override
  List<Type> get superStates => [
        HomeStates,
        BottomContainerStates,
        GetDevicesStates,
      ];
}

abstract class HomeStates implements SuperState {
  @override
  List<Type> get superStates => [HomeStates];
}

abstract class HomeAnimationsStates implements HomeStates, MainButtonStates {
  @override
  List<Type> get superStates => [
        HomeStates,
        MainButtonStates,
        HomeAnimationsStates,
      ];
}

abstract class SendHeightStates implements HomeStates {
  @override
  List<Type> get superStates => [
        HomeStates,
        SendHeightStates,
      ];
}

abstract class ConnectToDeviceStates implements HomeStates {
  @override
  List<Type> get superStates => [
        HomeStates,
        ConnectToDeviceStates,
      ];
}

abstract class ConnectionBannerStates
    implements HomeStates, BottomContainerStates {
  @override
  List<DeviceEntity> get devices => [];

  @override
  List<Type> get superStates => [
        HomeStates,
        BottomContainerStates,
        ConnectionBannerStates,
      ];
}

abstract class DisconnectDeviceStates implements HomeStates {
  @override
  List<Type> get superStates => [
        HomeStates,
        DisconnectDeviceStates,
      ];
}
