part of 'home_animations_cubit.dart';

class HomeAnimationsDismissedState extends HomeAnimationsStates {
  @override
  MainButtonStatesEnum get mainButtonState => MainButtonStatesEnum.dismissed;
}

class HomeAnimationsShowingDevicesState extends HomeAnimationsStates {
  @override
  MainButtonStatesEnum get mainButtonState => MainButtonStatesEnum.showingDevices;
}

class HomeAnimationsShowingInputFormState extends HomeAnimationsStates {
  @override
  MainButtonStatesEnum get mainButtonState => MainButtonStatesEnum.connected;
}
