import 'package:ergonomic_office_chair_manager/modules/home/domain/use_cases/connect_to_device_use_case.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/use_cases/connection_stream_use_case.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/use_cases/get_devices_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/device_entity.dart';
import '../../../domain/use_cases/disconnect_device_use_case.dart';

part 'connection_states.dart';

class ConnectionCubit extends Cubit<ConnectionStates> {
  final GetDevicesUseCase _getDevicesUseCase;
  final ConnectToDeviceUseCase _connectToDeviceUseCase;
  final DisconnectDeviceUseCase _disconnectDeviceUseCase;

  ConnectionCubit({
    required ConnectionStreamUseCase connectionStreamUseCase,
    required GetDevicesUseCase getDevicesUseCase,
    required ConnectToDeviceUseCase connectToDeviceUseCase,
    required DisconnectDeviceUseCase disconnectDeviceUseCase,
  })  : _getDevicesUseCase = getDevicesUseCase,
        _connectToDeviceUseCase = connectToDeviceUseCase,
        _disconnectDeviceUseCase = disconnectDeviceUseCase,
        super(ConnectionInitialState()) {
    _subscribeToConnectionState(connectionStreamUseCase);
  }

  var devices = <DeviceEntity>[];
  var _isConnectionLoading = false;

  get isConnectionLoading => _isConnectionLoading;

  set isConnectionLoading(isConnectionLoading) {
    _isConnectionLoading = isConnectionLoading;
    if (isConnectionLoading) {
      emit(ConnectionConnectingState());
    }
  }

  DeviceEntity? _connectedDevice;

  DeviceEntity? get connectedDevice => _connectedDevice;

  set connectedDevice(DeviceEntity? value) {
    _connectedDevice = value;

    if (value == null) {
      isConnected = false;
    }
  }

  var _isConnected = false;

  bool get isConnected => _isConnected;

  set isConnected(bool value) {
    _isConnected = value;

    if (!_isConnected && _connectedDevice != null) {
      _connectedDevice = null;
    }

    if (isConnected) {
      emit(ConnectionConnectedState());
    } else {
      emit(ConnectionDisconnectedState());
    }
  }

  void _subscribeToConnectionState(
    ConnectionStreamUseCase connectionStreamUseCase,
  ) {
    connectionStreamUseCase().listen(
      (connectionStateEntity) {
        _updateIsConnected(connectionStateEntity.isConnected);
      },
    );
  }

  void _updateIsConnected(bool isConnected) {
    this.isConnected = isConnected;
  }

  void getDevices() async {
    final devicesResult = await _getDevicesUseCase();
    devicesResult.fold<void>(
      (failure) => emit(
        ConnectionGetDevicesFailedState(message: failure.message),
      ),
      (devices) => emit(ConnectionGetDevicesSuccessState()),
    );
  }

  void connectToDevice(String deviceId) async {
    if (isConnected) {
      emit(ConnectionAlreadyConnectedState());
      return;
    }

    isConnectionLoading = true;

    final connectionResult = await _connectToDeviceUseCase(
      ConnectToDeviceUseCaseParameters(deviceId),
    );

    isConnectionLoading = false;

    connectionResult.fold<void>(
      (failure) => emit(
        ConnectionConnectingFailedState(message: failure.message),
      ),
      (_) {
        _updateIsConnected(true);
        emit(ConnectionConnectingDoneState());
      },
    );
  }

  void disconnectDevice() async {
    final isNotConnected = !isConnected || _connectedDevice == null;
    if (isNotConnected) {
      emit(ConnectionAlreadyNotConnectedState());
      return;
    }

    final disconnectionResult = await _disconnectDeviceUseCase(
      DisconnectDeviceUseCaseParameters(_connectedDevice!.id),
    );

    disconnectionResult.fold<void>(
      (failure) => emit(
        DisconnectionFailedState(message: failure.message),
      ),
      (_) {
        _updateIsConnected(false);
        emit(DisconnectionSuccessState());
      },
    );
  }
}
