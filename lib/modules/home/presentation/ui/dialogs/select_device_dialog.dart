import 'package:ergonomic_office_chair_manager/core/functions/media_query_utils.dart';
import 'package:ergonomic_office_chair_manager/modules/home/presentation/blocs/connection_cubit/connection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showSelectDeviceDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const SimpleDialog(
        title: _ViewDevicesDialog(),
      );
    },
  );
}

class _ViewDevicesDialog extends StatelessWidget {
  const _ViewDevicesDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final connectionCubit = context.watch<ConnectionCubit>();
    final devices = connectionCubit.devices;

    if (connectionCubit.isConnectionLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (devices.isEmpty) {
      return const Center(
        child: Text(
          'Did not find any devices',
          style: TextStyle(
            fontSize: 24,
            color: Colors.red,
          ),
        ),
      );
    }

    return SizedBox(
      height: context.screenHeight * 0.5,
      width: context.screenWidth * 0.8,
      child: Scaffold(
        body: ListView.builder(
          itemCount: devices.length,
          itemBuilder: (context, index) {
            final device = devices[index];
            return ListTile(
              title: Text(device.name),
              subtitle: Text(device.id),
              onTap: () => connectionCubit.connectToDevice(device.id),
            );
          },
        ),
      ),
    );
  }
}
