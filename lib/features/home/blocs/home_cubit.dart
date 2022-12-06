import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_connector_interface.dart';
import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_device_model.dart';
import 'package:ergonomic_office_chair_manager/core/functions/print.dart';
import 'package:ergonomic_office_chair_manager/features/home/data/ergonomic_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required HomeRepo homeRepo,
    required BluetoothConnectorInterface bluetoothConnector,
  })  : _repo = homeRepo,
        _bluetoothConnector = bluetoothConnector,
        super(HomeBlocInitialState()) {
    _bluetoothConnector.isConnectedBroadcastStream.listen((isConnected) {
      this.isConnected = isConnected;
      if (isConnected) {
        emit(BluetoothConnectedStatusState());
      } else {
        emit(BluetoothDisconnectedStatusState());
      }
    });

    _repo.getSavedSession().then(
      (value) {
        if (value != null) {
          emit(HomeLastSessionGotState(value));
        }
      },
    );
  }

  final HomeRepo _repo;
  final BluetoothConnectorInterface _bluetoothConnector;
  var bluetoothDevices = <BluetoothDeviceModel>[];
  var isConnected = false;
  var isConnectionLoading = false;
  final heightFormKey = GlobalKey<FormState>();
  final heightFormController = TextEditingController();

  Future<bool> get isBluetoothEnabled => _bluetoothConnector.isEnabled;

  Future<void> getBluetoothDevices() async {
    if (!await isBluetoothEnabled) {
      emit(BluetoothConnectionFailedState(message: 'Bluetooth is closed'));
    }

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
      isConnectionLoading = true;
      emit(BluetoothConnectingState());

      final result = await _bluetoothConnector.connect(bluetoothDevice);

      isConnectionLoading = false;
      if (result) {
        emit(BluetoothConnectionDoneState());
      } else {
        throw 'Connection Error';
      }
    } catch (_) {
      emit(BluetoothConnectionFailedState());
    }
  }

  void disconnect() async {
    emit(BluetoothDisconnectingState());
    final isDisconnectingSuccessful = await _bluetoothConnector.disconnect();
    if (isDisconnectingSuccessful) {
      emit(BluetoothDisconnectingSuccessfulState());
    } else {
      emit(BluetoothDisconnectingFailedState());
    }
  }

  void sendHeightsToBluetooth() {
    if (heightFormKey.currentState?.validate() ?? false) {
      final heightsModel = ErgonomicHeightCalculator.calculateHeights(
        int.parse(heightFormController.text.trim()),
      );

      _bluetoothConnector.send('${heightsModel.chairHeightInCm}');
      _repo.saveSession(heightsModel.userHeightInCm);
    }
  }
}
