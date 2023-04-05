import 'dart:math';

import 'package:ergonomic_office_chair_manager/core/functions/show_snack_bar.dart';
import 'package:ergonomic_office_chair_manager/stateful_bloc/stateful_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/functions/media_query_utils.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../injector.dart';
import '../../blocs/connect_to_device_cubit/connect_to_device_cubit.dart';
import '../../blocs/connection_stream_cubit/connection_stream_cubit.dart';
import '../../blocs/disconnect_device_cubit/disconnect_device_cubit.dart';
import '../../blocs/get_devices_cubit/get_devices_cubit.dart';
import '../../blocs/home_animations_cubit/home_animations_cubit.dart';
import '../../blocs/send_height_cubit/send_height_cubit.dart';
import '../../blocs/state_organizer.dart';
import '../widgets/bottom_container.dart';
import '../widgets/connection_status_widget.dart';
import '../widgets/monitor_icon.dart';
import '../widgets/select_device_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController introductionAnimationController;
  late final AnimationController showDevicesAnimationController;

  @override
  void initState() {
    introductionAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    showDevicesAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => HomeAnimationsCubit(
        introductionAnimationController: introductionAnimationController,
        showDevicesAnimationController: showDevicesAnimationController,
      )..animateIntroduction(),
      child: Builder(
        builder: (context) {
          final animationCubit = context.read<HomeAnimationsCubit>();

          final showDevicesAnimation = animationCubit.showDevicesAnimation;

          return Scaffold(
            appBar: AppBar(
              title: const Text(AppStrings.eocManager),
            ),
            body: StatefulBlocListener<HomeStates>(
              listener: (context, state) {
                if (state is ConnectionBannerDisconnectedState) {
                  animationCubit.animateShowDevicesBackward();
                }

                if (state is ConnectToDeviceSuccessState) {
                  animationCubit.animateShowInputForm();
                  context.showSnackBar('Connected Successfully');
                }

                if (state is ConnectToDeviceFailedState) {
                  context.showSnackBar(state.message);
                }

                if (state is DisconnectionSuccessState) {
                  context.showSnackBar('Disconnected');
                }

                if (state is DisconnectionFailedState) {
                  context.showSnackBar(state.message);
                }

                if (state is GetDevicesFailedState) {
                  context.showSnackBar(state.message);
                }

                if (state is SendHeightFailedState) {
                  context.showSnackBar(state.message);
                }
              },
              body: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: context.screenWidth * 0.2,
                    ),
                    child: const AnimatedConnectionStatusBanner(),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const AnimatedMonitorIcon(),
                        const AnimatedSelectDeviceButton(),
                        AnimatedBuilder(
                          animation: showDevicesAnimation,
                          builder: (context, child) => SizedBox(
                            height: max(
                              context.screenHeight *
                                  0.5 *
                                  showDevicesAnimation.value,
                              200,
                            ),
                            child: child!,
                          ),
                          child: const BottomContainer(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
