import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/connection_stream_use_case.dart';

part 'connection_stream_states.dart';

class ConnectionStreamCubit extends Cubit<ConnectionStates> {
  ConnectionStreamCubit({
    required ConnectionStreamUseCase connectionStreamUseCase,
  }) : super(ConnectionInitialState()) {
    _subscribeToConnectionState(connectionStreamUseCase);
  }

  void _subscribeToConnectionState(
    ConnectionStreamUseCase connectionStreamUseCase,
  ) {
    connectionStreamUseCase().listen(
      (connectionStateEntity) {
        final isConnected = connectionStateEntity.isConnected;

        if (isConnected) {
          emit(ConnectionConnectedState());
        } else {
          emit(ConnectionDisconnectedState());
        }
      },
    );
  }
}
