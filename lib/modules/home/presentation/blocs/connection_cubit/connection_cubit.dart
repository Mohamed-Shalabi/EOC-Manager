import 'package:ergonomic_office_chair_manager/modules/home/domain/entities/connection_entity.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/use_cases/connect_to_device_use_case.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/use_cases/disconnect_device_use_case.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/use_cases/send_height_use_case.dart';
import 'package:ergonomic_office_chair_manager/modules/home/presentation/ui/widgets/send_height_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/data_holders/device.dart';

part 'connection_state.dart';

class ConnectionCubit extends Cubit<ConnectionStates> {
  ConnectionCubit(
    this._entity,
    this._connectToDeviceUseCase,
    this._disconnectDeviceUseCase,
    this._sendHeightUseCase,
  ) : super(const ConnectionStates.initial());

  final ConnectionEntity _entity;
  final ConnectToDeviceUseCase _connectToDeviceUseCase;
  final DisconnectDeviceUseCase _disconnectDeviceUseCase;
  final SendHeightUseCase _sendHeightUseCase;

  final heightFormKey = GlobalKey<FormState>();
  final userHeightTextController = TextEditingController();

  void getDevices() async {
    emit(state._toLoading());

    final result = await _entity.getDevices();

    result.fold(
      (failure) => emit(state._toError(failure.message)),
      (devices) => emit(state._toGotDevices(devices)),
    );
  }

  void connect(Device device) async {
    emit(state._toLoading());

    final result = await _connectToDeviceUseCase(
      ConnectToDeviceUseCaseParameters(device.id),
    );

    result.fold(
      (failure) => emit(state._toError(failure.message)),
      (device) => emit(state._toConnected(device)),
    );
  }

  void disconnect() async {
    emit(state._toLoading());

    final result = await _disconnectDeviceUseCase();

    result.fold(
      (failure) => emit(state._toError(failure.message)),
      (device) => emit(state._toDisconnected()),
    );
  }

  void sendHeight() async {
    emit(state._toLoading());

    if (!heightFormKey.currentState!.validate()) {
      emit(state._toStopLoading());
      return;
    }

    final userHeight = int.parse(userHeightTextController.text.trim());
    final result = await _sendHeightUseCase(
      SendHeightUseCaseParameters(userHeight),
    );

    result.fold(
      (failure) => emit(state._toError(failure.message)),
      (device) => emit(state._toDataSent()),
    );
  }

  void resetState() => emit(state._toIdle());
}
