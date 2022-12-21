import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/my_text.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../injector.dart';
import '../../blocs/connect_to_device_cubit/connect_to_device_cubit.dart';
import '../../blocs/connection_stream_cubit/connection_stream_cubit.dart';
import '../../blocs/disconnect_device_cubit/disconnect_device_cubit.dart';
import '../dialogs/select_device_dialog.dart';

class SelectDeviceButton extends StatelessWidget {
  const SelectDeviceButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionStreamCubit, ConnectionStates>(
      builder: (BuildContext context, ConnectionStates state) {
        final connectionCubit = context.read<DisconnectDeviceCubit>();
        final isConnected = state is ConnectionConnectedState;

        return TextButton(
          onPressed: isConnected
              ? connectionCubit.disconnectDevice
              : () => showSelectDeviceDialog(
                    context,
                    connectToDeviceCubit: Injector.get<ConnectToDeviceCubit>(),
                  ),
          child: MyText(
            isConnected ? AppStrings.disconnect : AppStrings.selectDevice,
            style: AppTextStyles.buttonStyle,
          ),
        );
      },
    );
  }
}
