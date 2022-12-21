import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/my_text.dart';
import '../../../../../core/functions/media_query_utils.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../injector.dart';
import '../../blocs/connect_to_device_cubit/connect_to_device_cubit.dart';
import '../../blocs/get_devices_cubit/get_devices_cubit.dart';

void showSelectDeviceDialog(
  BuildContext context, {
  required ConnectToDeviceCubit connectToDeviceCubit,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: connectToDeviceCubit),
          BlocProvider(
            create: (context) => Injector.get<GetDevicesCubit>()..getDevices(),
          ),
        ],
        child: const SimpleDialog(
          title: _ViewDevicesDialog(),
        ),
      );
    },
  );
}

class _ViewDevicesDialog extends StatelessWidget {
  const _ViewDevicesDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectToDeviceCubit, ConnectToDeviceStates>(
      builder: (BuildContext context, ConnectToDeviceStates state) {
        final isConnecting = state is ConnectToDeviceLoadingState;
        if (isConnecting) {
          return const Center(child: CircularProgressIndicator());
        }

        return BlocBuilder<GetDevicesCubit, GetDevicesStates>(
          builder: (BuildContext context, GetDevicesStates state) {
            final isLoading = state is GetDevicesLoadingState;
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final failedGettingDevices = state is GetDevicesFailedState ||
                state is GetDevicesSuccessState && state.devices.isEmpty;
            if (failedGettingDevices) {
              return const Center(
                child: MyText(
                  AppStrings.didNotFindDevices,
                  style: AppTextStyles.warningStyle,
                ),
              );
            }

            if (state is GetDevicesSuccessState) {
              final devices = state.devices;
              SizedBox(
                height: context.screenHeight * 0.5,
                width: context.screenWidth * 0.8,
                child: Scaffold(
                  body: ListView.builder(
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      final device = devices[index];
                      return ListTile(
                        title: MyText(device.name),
                        subtitle: MyText(device.id),
                        onTap: () => context
                            .read<ConnectToDeviceCubit>()
                            .connectToDevice(device.id),
                      );
                    },
                  ),
                ),
              );
            }

            throw 'Not listed state';
          },
        );
      },
    );
  }
}
