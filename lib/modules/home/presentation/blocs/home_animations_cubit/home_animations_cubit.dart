import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAnimationsCubit extends Cubit<bool> {
  HomeAnimationsCubit({
    required this.introductionAnimationController,
    required this.showDevicesAnimationController,
  }) : super(false) {
    _initAnimations();
  }

  final AnimationController introductionAnimationController;
  final AnimationController showDevicesAnimationController;

  late final Animation<double> monitorAnimation;
  late final Animation<double> selectDeviceButtonAnimation;
  late final Animation<double> connectionStatusBannerAnimation;
  late final Animation<double> showDevicesAnimation;

  var isShowingDevices = false;

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

  Future<void> animateShowDevices() async {
    if (isShowingDevices) {
      await _animateShowDevicesBackward();
      emit(false);
    } else {
      await _animateShowDevicesForward();
      emit(true);
    }
  }

  Future<void> _animateShowDevicesForward() async {
    final shouldAnimate = showDevicesAnimationController.value == 0.0;
    if (shouldAnimate) {
      await showDevicesAnimationController.forward();
      isShowingDevices = true;
    }
  }

  Future<void> _animateShowDevicesBackward() async {
    final shouldAnimate = showDevicesAnimationController.value == 1;
    if (shouldAnimate) {
      await showDevicesAnimationController.reverse();
      isShowingDevices = false;
    }
  }

  void animateShowInputForm() {
    showDevicesAnimationController.reverse();
    isShowingDevices = false;
  }
}
