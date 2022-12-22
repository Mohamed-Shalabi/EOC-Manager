import 'package:ergonomic_office_chair_manager/modules/home/presentation/blocs/connection_stream_cubit/connection_stream_cubit.dart';
import 'package:ergonomic_office_chair_manager/modules/home/presentation/blocs/disconnect_device_cubit/disconnect_device_cubit.dart';
import 'package:ergonomic_office_chair_manager/modules/home/presentation/ui/widgets/send_height_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/my_circular_progress_indicator.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../domain/entities/device_entity.dart';
import '../../blocs/connect_to_device_cubit/connect_to_device_cubit.dart';
import '../../blocs/get_devices_cubit/get_devices_cubit.dart';
import '../../blocs/home_animations_cubit/home_animations_cubit.dart';
import 'bluetooth_circle_avatar.dart';
import 'devices_list_view.dart';
import 'did_not_find_devices_text.dart';

class BottomContainer extends StatelessWidget {
  const BottomContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final holder = context.read<HomeAnimationsCubit>();
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
    return BlocBuilder<DisconnectDeviceCubit, DisconnectDeviceStates>(
      builder: (context, state) {
        final isDisconnecting = state is DisconnectDeviceLoadingState;

        return BlocBuilder<ConnectionStreamCubit, ConnectionStates>(
          builder: (context, state) {
            final isConnected = state is ConnectionConnectedState;

            return BlocBuilder<ConnectToDeviceCubit, ConnectToDeviceStates>(
              builder: (BuildContext context, ConnectToDeviceStates state) {
                final isConnecting = state is ConnectToDeviceLoadingState;

                return BlocBuilder<GetDevicesCubit, GetDevicesStates>(
                  builder: (BuildContext context, GetDevicesStates state) {
                    final isIdle = state is GetDevicesIdleState;
                    final isGetDevicesLoading = state is GetDevicesLoadingState;
                    final failedGettingDevices =
                        state is GetDevicesFailedState ||
                            state is GetDevicesSuccessState &&
                                state.devices.isEmpty;

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return child is! RepositoryProvider<List<DeviceEntity>>
                            ? ScaleTransition(scale: animation, child: child)
                            : FadeTransition(opacity: animation, child: child);
                      },
                      child: isIdle
                          ? const BluetoothCircleAvatar()
                          : isGetDevicesLoading ||
                                  isConnecting ||
                                  isDisconnecting
                              ? const Center(
                                  child: MyCircularProgressIndicator())
                              : isConnected
                                  ? const SendHeightWidget()
                                  : failedGettingDevices
                                      ? const DidNotFindDevicesText()
                                      : state is GetDevicesSuccessState
                                          ? RepositoryProvider<
                                              List<DeviceEntity>>(
                                              create: (_) => state.devices,
                                              child: const DevicesListView(),
                                            )
                                          : throw 'Unknown State',
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
