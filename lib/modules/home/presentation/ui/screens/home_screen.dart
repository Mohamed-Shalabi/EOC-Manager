import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/functions/media_query_utils.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../blocs/connection_stream_cubit/connection_stream_cubit.dart';
import '../widgets/connection_status_widget.dart';
import '../widgets/select_device_button.dart';
import '../widgets/send_height_button.dart';
import '../widgets/user_height_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.home),
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
          BlocBuilder<ConnectionStreamCubit, ConnectionStates>(
            builder: (BuildContext context, ConnectionStates state) {
              final isConnected = state is ConnectionConnectedState;
              if (isConnected) {
                return Column(
                  children: [
                    SizedBox(height: context.screenHeight * 0.1),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: UserHeightForm(),
                    ),
                    const SendHeightButton(),
                    SizedBox(height: context.screenHeight * 0.2),
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
