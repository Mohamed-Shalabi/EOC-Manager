import 'package:ergonomic_office_chair_manager/core/functions/media_query_utils.dart';
import 'package:ergonomic_office_chair_manager/core/functions/show_snack_bar.dart';
import 'package:ergonomic_office_chair_manager/features/home/blocs/home_cubit.dart';
import 'package:ergonomic_office_chair_manager/features/home/data/ergonomic_calculator.dart';
import 'package:ergonomic_office_chair_manager/features/home/ui/view_bluetooth_devices_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeGetBluetoothDevicesFailedState) {
            context.showSnackBar('Failed to connect');
          }

          if (state is BluetoothSendDataFailedState) {
            context.showSnackBar(state.message);
          }
        },
        builder: (context, state) {
          if (state is HomeGetBluetoothDevicesLoadingState ||
              state is BluetoothSendDataLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final viewModel = context.read<HomeCubit>();

          return ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: context.screenWidth * 0.2,
                ),
                child: Container(
                  width: context.screenWidth * 0.4,
                  height: 36,
                  decoration: BoxDecoration(
                    color: viewModel.isConnected
                        ? Colors.greenAccent.shade400
                        : Colors.red.shade300,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      viewModel.isConnected ? 'Connected' : 'Not Connected',
                    ),
                  ),
                ),
              ),
              SizedBox(height: context.screenHeight * 0.2),
              TextButton(
                onPressed: () {
                  context.read<HomeCubit>().getBluetoothDevices();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const SimpleDialog(
                        title: ViewBluetoothDevicesDialog(),
                      );
                    },
                  );
                },
                child: const Text(
                  'Select Device',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              if (viewModel.isConnected) ...[
                SizedBox(height: context.screenHeight * 0.2),
                Form(
                  child: TextFormField(
                    controller: viewModel.heightFormController,
                    decoration: InputDecoration(
                      hintText: 'Enter your height in English Letters',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      final intValue = int.tryParse(value?.trim() ?? '');
                      if (intValue == null) {
                        return 'Write a correct number';
                      } else if (!ErgonomicHeightCalculator.isInsideRange(
                        intValue,
                      )) {
                        return 'Write a number between '
                            '${ErgonomicHeightCalculator.minUserHeight} '
                            'and ${ErgonomicHeightCalculator.maxUserHeight}';
                      }

                      return null;
                    },
                  ),
                ),
                TextButton(
                  onPressed: viewModel.sendHeightToBluetooth,
                  child: const Text(
                    'Send',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                SizedBox(height: context.screenHeight * 0.2),
              ]
            ],
          );
        },
      ),
    );
  }
}
