import 'package:ergonomic_office_chair_manager/features/home/domain/use_cases/connect_to_device_use_case.dart';
import 'package:ergonomic_office_chair_manager/features/home/domain/use_cases/connection_stream_use_case.dart';
import 'package:ergonomic_office_chair_manager/features/home/domain/use_cases/get_devices_use_case.dart';
import 'package:ergonomic_office_chair_manager/features/home/domain/use_cases/send_height_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/device_entity.dart';
import '../../domain/use_cases/disconnect_device_use_case.dart';

part 'home_states.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetDevicesUseCase _getDevicesUseCase;
  final ConnectToDeviceUseCase _connectToDeviceUseCase;
  final DisconnectDeviceUseCase _disconnectDeviceUseCase;
  final SendHeightUseCase _sendHeightUseCase;

  HomeCubit({
    required ConnectionStreamUseCase connectionStreamUseCase,
    required GetDevicesUseCase getDevicesUseCase,
    required ConnectToDeviceUseCase connectToDeviceUseCase,
    required DisconnectDeviceUseCase disconnectDeviceUseCase,
    required SendHeightUseCase sendHeightUseCase,
    required this.userHeightTextController,
  })  : _getDevicesUseCase = getDevicesUseCase,
        _connectToDeviceUseCase = connectToDeviceUseCase,
        _disconnectDeviceUseCase = disconnectDeviceUseCase,
        _sendHeightUseCase = sendHeightUseCase,
        super(HomeInitialState()) {
    subscribeToConnectionState(connectionStreamUseCase);
  }

  var devices = <DeviceEntity>[];
  final TextEditingController userHeightTextController;

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
  }

  String get _userHeightTrimmedText => userHeightTextController.text.trim();

  int get _userHeight => int.parse(_userHeightTrimmedText);

  void subscribeToConnectionState(
    ConnectionStreamUseCase connectionStreamUseCase,
  ) {
    connectionStreamUseCase(
      ConnectionStreamUseCaseParameters(),
    ).listen(updateIsConnected);
  }

  void updateIsConnected(bool isConnected) {
    this.isConnected = isConnected;
  }

  void getDevices() async {
    devices = await _getDevicesUseCase(GetDevicesUseCaseParameters());
  }

  void connectToDevice(String deviceId) async {
    if (isConnected) {
      return;
    }

    final connectionDoneEntity = await _connectToDeviceUseCase(
      ConnectToDeviceUseCaseParameters(deviceId),
    );
    updateIsConnected(connectionDoneEntity.isConnected);
  }

  void disconnectDevice() async {
    final isNotConnected = !isConnected || _connectedDevice == null;
    if (isNotConnected) {
      return;
    }

    final disconnectionDoneEntity = await _disconnectDeviceUseCase(
      DisconnectDeviceUseCaseParameters(_connectedDevice!.id),
    );
    final isDisconnected = disconnectionDoneEntity.isDone;
    updateIsConnected(!isDisconnected);
  }

  void sendHeight() async {
    _sendHeightUseCase(
      SendHeightUseCaseParameters(_userHeight),
    );
  }
}
