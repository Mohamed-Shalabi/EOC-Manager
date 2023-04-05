import 'package:ergonomic_office_chair_manager/modules/home/presentation/ui/multi_state_organizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stateful_bloc/flutter_stateful_bloc.dart';

import '../state_organizer.dart';

part 'home_animation_states.dart';

class HomeAnimationsCubit extends StatefulCubit<HomeAnimationsStates> {
  HomeAnimationsCubit({
    required this.introductionAnimationController,
    required this.showDevicesAnimationController,
  }) {
    _initAnimations();
  }

  final AnimationController introductionAnimationController;
  final AnimationController showDevicesAnimationController;

  late final Animation<double> monitorAnimation;
  late final Animation<double> selectDeviceButtonAnimation;
  late final Animation<double> connectionStatusBannerAnimation;
  late final Animation<double> showDevicesAnimation;

  void _initAnimations() {
    monitorAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: introductionAnimationController,
        curve: const Interval(
          0.0,
          0.55,
          curve: Curves.easeInOutCubicEmphasized,
        ),
      ),
    );

    selectDeviceButtonAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: introductionAnimationController,
        curve: const Interval(
          0.2,
          0.66,
          curve: Curves.easeInOutCubicEmphasized,
        ),
      ),
    );

    connectionStatusBannerAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: introductionAnimationController,
        curve: const Interval(
          0.5,
          1.0,
          curve: Curves.easeInOutCubicEmphasized,
        ),
      ),
    );

    showDevicesAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: showDevicesAnimationController,
        curve: Curves.easeInOutCubicEmphasized,
        reverseCurve: Curves.easeInOutCubic,
      ),
    );
  }

  Future<bool> animateIntroduction() async {
    await introductionAnimationController.forward();
    return true;
  }

  bool get isShowingDevices => showDevicesAnimationController.value == 1;

  Future<void> animateShowDevicesForward() async {
    if (!isShowingDevices) {
      await showDevicesAnimationController.forward();
      emit(HomeAnimationsShowingDevicesState());
    }
  }

  Future<void> animateShowDevicesBackward() async {
    if (isShowingDevices) {
      await showDevicesAnimationController.reverse();
      emit(HomeAnimationsDismissedState());
    }
  }

  void animateShowInputForm() {
    showDevicesAnimationController.reverse();
    emit(HomeAnimationsShowingInputFormState());
  }
}
