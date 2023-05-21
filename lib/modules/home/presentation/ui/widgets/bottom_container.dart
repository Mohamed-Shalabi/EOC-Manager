import 'package:ergonomic_office_chair_manager/modules/home/presentation/blocs/connection_cubit/connection_cubit.dart';
import 'package:ergonomic_office_chair_manager/modules/home/presentation/ui/widgets/send_height_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/my_circular_progress_indicator.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../domain/data_holders/device.dart';
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
    return BlocBuilder<ConnectionCubit, ConnectionStates>(
      builder: (context, state) {
        final isIdle = state.isIdle;
        final isLoading = state.isLoading;
        final isConnected = state.isConnected;
        final devices = state.availableDevices;
        final noDevicesFound = state.availableDevices?.isEmpty ?? false;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return child is! RepositoryProvider<List<Device>>
                ? ScaleTransition(scale: animation, child: child)
                : FadeTransition(opacity: animation, child: child);
          },
          child: isIdle
              ? const BluetoothCircleAvatar()
              : isLoading
                  ? const Center(child: MyCircularProgressIndicator())
                  : isConnected
                      ? const SendHeightWidget()
                      : noDevicesFound
                          ? const DidNotFindDevicesText()
                          : devices != null && devices.isNotEmpty
                              ? RepositoryProvider<List<Device>>(
                                  create: (_) => devices,
                                  child: const DevicesListView(),
                                )
                              : throw 'Unknown State',
        );
      },
    );
  }
}
