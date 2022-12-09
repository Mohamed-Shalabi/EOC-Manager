import 'package:ergonomic_office_chair_manager/core/utils/app_text_styles.dart';
import 'package:ergonomic_office_chair_manager/modules/home/presentation/blocs/connection_cubit/connection_cubit.dart';
import 'package:ergonomic_office_chair_manager/modules/home/presentation/ui/dialogs/select_device_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/my_text.dart';
import '../../../../../core/utils/app_strings.dart';

class SelectDeviceButton extends StatelessWidget {
  const SelectDeviceButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final connectionViewModel = context.watch<ConnectionCubit>();

    return TextButton(
      onPressed: connectionViewModel.isConnected
          ? connectionViewModel.disconnectDevice
          : () => showSelectDeviceDialog(context),
      child: MyText(
        connectionViewModel.isConnected
            ? AppStrings.disconnect
            : AppStrings.selectDevice,
        style: AppTextStyles.buttonStyle,
      ),
    );
  }
}
