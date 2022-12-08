import 'package:ergonomic_office_chair_manager/core/functions/media_query_utils.dart';
import 'package:ergonomic_office_chair_manager/core/functions/show_snack_bar.dart';
import 'package:ergonomic_office_chair_manager/modules/home/presentation/blocs/connection_cubit/connection_cubit.dart';
import 'package:ergonomic_office_chair_manager/modules/home/presentation/blocs/send_height_cubit/send_height_cubit.dart';
import 'package:ergonomic_office_chair_manager/modules/home/presentation/ui/widgets/select_device_button.dart';
import 'package:ergonomic_office_chair_manager/modules/home/presentation/ui/widgets/user_height_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/connection_status_widget.dart';
import '../widgets/send_height_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendHeightCubit, SendHeightStates>(
      listener: _onSendHeightEvent,
      child: BlocConsumer<ConnectionCubit, ConnectionStates>(
        listener: _onConnectionEvent,
        builder: (context, state) {
          final connectionViewModel = context.read<ConnectionCubit>();
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
            ),
            body: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: context.screenWidth * 0.2,
                  ),
                  child: const ConnectionStatusWidget(),
                ),
                SizedBox(height: context.screenHeight * 0.2),
                const SelectDeviceButton(),
                if (connectionViewModel.isConnected) ...[
                  SizedBox(height: context.screenHeight * 0.1),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: UserHeightForm(),
                  ),
                  const SendHeightButton(),
                  SizedBox(height: context.screenHeight * 0.2),
                ]
              ],
            ),
          );
        },
      ),
    );
  }

  void _onConnectionEvent(BuildContext context, ConnectionStates state) {
    if (state is ConnectionConnectingDoneState) {
      context.showSnackBar('Connected Successfully');
    }

    if (state is ConnectionConnectingFailedState) {
      context.showSnackBar('Could not connect');
    }

    if (state is ConnectionAlreadyConnectedState) {
      context.showSnackBar('Already connected');
    }

    if (state is ConnectionAlreadyNotConnectedState) {
      context.showSnackBar('Already not connected');
    }

    if (state is ConnectionGetDevicesFailedState) {
      context.showSnackBar('Could not get devices');
    }
  }

  void _onSendHeightEvent(BuildContext context, SendHeightStates state) {
    if (state is SendHeightSuccessState) {
      context.showSnackBar('Send Successfully');
    }

    if (state is SendHeightFailedState) {
      context.showSnackBar('Could not send data');
    }
  }
}
