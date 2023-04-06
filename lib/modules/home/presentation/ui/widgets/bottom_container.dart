import 'package:ergonomic_office_chair_manager/modules/home/presentation/ui/multi_state_organizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stateful_bloc/flutter_stateful_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../domain/entities/device_entity.dart';
import '../../blocs/connection_stream_cubit/connection_stream_cubit.dart';
import '../../blocs/home_animations_cubit/home_animations_cubit.dart';
import 'bluetooth_circle_avatar.dart';
import 'devices_list_view.dart';
import 'did_not_find_devices_text.dart';
import 'send_height_widget.dart';

class BottomContainer extends StatelessWidget {
  const BottomContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final holder = context.readObject<HomeAnimationsCubit>();
    final connectionStatusBannerAnimation =
        holder.connectionStatusBannerAnimation;

    return AnimatedBuilder(
      animation: connectionStatusBannerAnimation,
      builder: (BuildContext context, Widget? child) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            right: 110 - connectionStatusBannerAnimation.value * 100,
            left: 110 - connectionStatusBannerAnimation.value * 100,
          ),
          decoration: BoxDecoration(
            color: AppColors.purple.withOpacity(
              connectionStatusBannerAnimation.value,
            ),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                200 - 150 * connectionStatusBannerAnimation.value,
              ),
            ),
          ),
          child: const BottomContainerContent(),
        );
      },
    );
  }
}

class BottomContainerContent extends StatelessWidget {
  const BottomContainerContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateConsumer<BottomContainerStates>(
      initialState: stateHolder.lastStateOfContextType(BottomContainerStates)
              as BottomContainerStates? ??
          ConnectionBannerDisconnectedState(),
      builder: (context, containerState) {
        final state = containerState.state;
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return child is! ObjectProvider<List<DeviceEntity>>
                ? ScaleTransition(scale: animation, child: child)
                : FadeTransition(opacity: animation, child: child);
          },
          child: state == BottomContainerStatesEnum.idle
              ? const BluetoothCircleAvatar()
              : state == BottomContainerStatesEnum.loading
                  ? const Center(child: CircularProgressIndicator(color: AppColors.white))
                  : state == BottomContainerStatesEnum.connected
                      ? const SendHeightWidget()
                      : state == BottomContainerStatesEnum.failedGettingDevices
                          ? const DidNotFindDevicesText()
                          : ObjectProvider<List<DeviceEntity>>(
                              create: (_) => containerState.devices,
                              child: const DevicesListView(),
                            ),
        );
      },
    );
  }
}
