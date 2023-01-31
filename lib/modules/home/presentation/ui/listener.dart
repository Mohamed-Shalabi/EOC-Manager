import 'package:ergonomic_office_chair_manager/core/functions/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/connect_to_device_cubit/connect_to_device_cubit.dart';
import '../blocs/connection_stream_cubit/connection_stream_cubit.dart';
import '../blocs/disconnect_device_cubit/disconnect_device_cubit.dart';
import '../blocs/get_devices_cubit/get_devices_cubit.dart';
import '../blocs/send_height_cubit/send_height_cubit.dart';

class HomeListeners extends StatelessWidget {
  const HomeListeners({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ConnectToDeviceCubit, ConnectToDeviceStates>(
          listener: (context, state) {
            if (state is ConnectToDeviceSuccessState) {
              context.showSnackBar('Connected Successfully');
            }

            if (state is ConnectToDeviceFailedState) {
              context.showSnackBar(state.message);
            }
          },
        ),
        BlocListener<ConnectionStreamCubit, ConnectionStates>(
          listener: (context, state) {
            if (state is ConnectionConnectedState) {
              context.showSnackBar('Connected');
            }

            if (state is ConnectionDisconnectedState) {
              context.showSnackBar('Disconnected');
            }
          },
        ),
        BlocListener<DisconnectDeviceCubit, DisconnectDeviceStates>(
          listener: (context, state) {
            if (state is DisconnectionFailedState) {
              context.showSnackBar(state.message);
            }
          },
        ),
        BlocListener<GetDevicesCubit, GetDevicesStates>(
          listener: (context, state) {
            if (state is GetDevicesFailedState) {
              context.showSnackBar(state.message);
            }
          },
        ),
        BlocListener<SendHeightCubit, SendHeightStates>(
          listener: (context, state) {
            if (state is SendHeightFailedState) {
              context.showSnackBar(state.message);
            }
          },
        ),
      ],
      child: child,
    );
  }
}
