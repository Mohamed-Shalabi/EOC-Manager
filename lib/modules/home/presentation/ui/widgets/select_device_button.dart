import 'package:ergonomic_office_chair_manager/modules/home/presentation/ui/multi_state_organizer.dart';
import 'package:flutter/material.dart';

import 'package:flutter_stateful_bloc/flutter_stateful_bloc.dart';
import '../../../../../core/components/my_text.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../injector.dart';
import '../../blocs/disconnect_device_cubit/disconnect_device_cubit.dart';
import '../../blocs/get_devices_cubit/get_devices_cubit.dart';
import '../../blocs/home_animations_cubit/home_animations_cubit.dart';

class AnimatedSelectDeviceButton extends StatelessWidget {
  const AnimatedSelectDeviceButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animation =
        context.readObject<HomeAnimationsCubit>().selectDeviceButtonAnimation;

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
    return StatefulBlocConsumer<MainButtonStates>(
      initialState: HomeAnimationsDismissedState(),
      builder: (context, state) {
        final isShowingDevices =
            state.mainButtonState == MainButtonStatesEnum.showingDevices;
        final isConnected =
            state.mainButtonState == MainButtonStatesEnum.connected;

        return TextButton(
          style: TextButton.styleFrom(
            backgroundColor: AppColors.purple,
            shape: const StadiumBorder(),
          ),
          onPressed: () async {
            final animationHolder = context.readObject<HomeAnimationsCubit>();
            final disconnectDeviceCubit = Injector.get<DisconnectDeviceCubit>();
            final getDevicesCubit = Injector.get<GetDevicesCubit>();

            if (isConnected) {
              await disconnectDeviceCubit.disconnectDevice();
            }

            Future<void> animateShowDevices() async {
              if (isShowingDevices) {
                await animationHolder.animateShowDevicesBackward();
              } else {
                await animationHolder.animateShowDevicesForward();
              }
            }

            animateShowDevices().then((_) {
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
        );
      },
    );
  }
}
