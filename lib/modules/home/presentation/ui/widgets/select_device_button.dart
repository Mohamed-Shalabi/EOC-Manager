import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/my_text.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../blocs/connection_stream_cubit/connection_stream_cubit.dart';
import '../../blocs/disconnect_device_cubit/disconnect_device_cubit.dart';
import '../../blocs/get_devices_cubit/get_devices_cubit.dart';
import '../../blocs/home_animations_cubit/home_animations_cubit.dart';

class AnimatedSelectDeviceButton extends StatelessWidget {
  const AnimatedSelectDeviceButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animation =
        context.read<HomeAnimationsCubit>().selectDeviceButtonAnimation;

    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Padding(
          padding: EdgeInsets.fromLTRB(0, 60 - 60 * animation.value, 0, 0),
          child: Opacity(
            opacity: animation.value,
            child: child,
          ),
        );
      },
      child: const Center(child: SelectDeviceButton()),
    );
  }
}

class SelectDeviceButton extends StatelessWidget {
  const SelectDeviceButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionStreamCubit, ConnectionStates>(
      builder: (BuildContext context, ConnectionStates state) {
        final isConnected = state is ConnectionConnectedState;

        return BlocBuilder<HomeAnimationsCubit, bool>(
          builder: (context, isShowingDevices) => TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.purple,
              shape: const StadiumBorder(),
            ),
            onPressed: () async {
              final animationHolder = context.read<HomeAnimationsCubit>();
              final disconnectDeviceCubit =
                  context.read<DisconnectDeviceCubit>();
              final getDevicesCubit = context.read<GetDevicesCubit>();

              if (isConnected) {
                await disconnectDeviceCubit.disconnectDevice();
              }

              animationHolder.animateShowDevices().then((_) {
                if (!isShowingDevices) {
                  getDevicesCubit.getDevices();
                } else {
                  getDevicesCubit.resetState();
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: MyText(
                isConnected
                    ? AppStrings.disconnect
                    : isShowingDevices
                        ? AppStrings.dismiss
                        : AppStrings.selectDevice,
                style: AppTextStyles.buttonStyle,
              ),
            ),
          ),
        );
      },
    );
  }
}
