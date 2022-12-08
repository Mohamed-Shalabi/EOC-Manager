import 'package:ergonomic_office_chair_manager/modules/home/presentation/blocs/connection_cubit/connection_cubit.dart';
import 'package:ergonomic_office_chair_manager/modules/home/presentation/ui/dialogs/select_device_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectDeviceButton extends StatelessWidget {
  const SelectDeviceButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final connectionViewModel = context.watch<ConnectionCubit>();

    return TextButton(
      onPressed: connectionViewModel.isConnected
          ? connectionViewModel.disconnectDevice
          : () => showSelectDeviceDialog(context),
      child: Text(
        connectionViewModel.isConnected ? 'Disconnect' : 'Select Device',
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
