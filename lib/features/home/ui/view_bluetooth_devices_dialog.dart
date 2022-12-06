import 'package:ergonomic_office_chair_manager/core/functions/media_query_utils.dart';
import 'package:ergonomic_office_chair_manager/core/functions/navigate.dart';
import 'package:ergonomic_office_chair_manager/core/functions/show_snack_bar.dart';
import 'package:ergonomic_office_chair_manager/features/home/blocs/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewBluetoothDevicesDialog extends StatelessWidget {
  const ViewBluetoothDevicesDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * 0.5,
      width: context.screenWidth * 0.8,
      child: Scaffold(
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is BluetoothConnectionFailedState) {
              context.showSnackBar('Bluetooth could not connect');
            }

            if (state is BluetoothConnectionDoneState) {
              context.showSnackBar('Bluetooth connected');
              context.pop();
            }
          },
          builder: (context, state) {
            final homeCubit = context.read<HomeCubit>();
            final bluetoothDevices = homeCubit.bluetoothDevices;

            if (homeCubit.isConnectionLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (bluetoothDevices.isEmpty) {
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

            return ListView.builder(
              itemCount: bluetoothDevices.length,
              itemBuilder: (context, index) {
                final bluetoothDevice = bluetoothDevices[index];
                return ListTile(
                  title: Text(bluetoothDevice.name),
                  subtitle: Text(bluetoothDevice.address),
                  onTap: () {
                    homeCubit.connectToBluetoothDevice(bluetoothDevice);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
