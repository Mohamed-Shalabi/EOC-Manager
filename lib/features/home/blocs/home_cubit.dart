import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_connector_interface.dart';
import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_device_model.dart';
import 'package:ergonomic_office_chair_manager/core/functions/print.dart';
import 'package:ergonomic_office_chair_manager/features/home/data/ergonomic_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required BluetoothConnectorInterface bluetoothConnector})
      : _bluetoothConnector = bluetoothConnector,
        super(HomeBlocInitialState()) {
    _bluetoothConnector.isConnectedStream.listen((event) {
      if (event) {
        emit(BluetoothConnectedStatusState());
      } else {
        emit(BluetoothDisconnectedStatusState());
      }
    });
  }

  final BluetoothConnectorInterface _bluetoothConnector;
  var bluetoothDevices = <BluetoothDeviceModel>[];
  var isConnected = false;
  final heightFormKey = GlobalKey<FormState>();
  final heightFormController = TextEditingController();

  void getBluetoothDevices() async {
    emit(HomeGetBluetoothDevicesLoadingState());
    try {
      bluetoothDevices = await _bluetoothConnector.getBluetoothDevices();

      emit(HomeGetBluetoothDevicesSuccessState());
    } catch (e, s) {
      emit(HomeGetBluetoothDevicesFailedState());
      printInDebugMode(e);
      printInDebugMode(s);
    }
  }

  void connectToBluetoothDevice(BluetoothDeviceModel bluetoothDevice) async {
    try {
      emit(BluetoothConnectingState());

      final result = await _bluetoothConnector.connect(bluetoothDevice);

      if (result) {
        emit(BluetoothConnectionDoneState());
      } else {
        throw 'Connection Error';
      }
    } catch (_) {
      emit(BluetoothConnectionFailedState());
    }
  }

  void sendHeightToBluetooth() {
    if (heightFormKey.currentState?.validate() ?? false) {
      final chairHeight = ErgonomicHeightCalculator.calculate(
        int.parse(heightFormController.text.trim()),
      );
    }
  }
}
