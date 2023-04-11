import 'package:flutter_stateful_bloc/flutter_stateful_bloc.dart';

import '../../../domain/use_cases/connection_stream_use_case.dart';
import '../state_organizer.dart';

part 'connection_stream_states.dart';

class ConnectionStreamCubit extends StatelessCubit<ConnectionBannerStates> {
  ConnectionStreamCubit({
    required ConnectionStreamUseCase connectionStreamUseCase,
  }) {
    _subscribeToConnectionState(connectionStreamUseCase);
  }

  void _subscribeToConnectionState(
    ConnectionStreamUseCase connectionStreamUseCase,
  ) {
    connectionStreamUseCase().listen(
      (connectionStateEntity) {
        final isConnected = connectionStateEntity.isConnected;

        if (isConnected) {
          emit(ConnectionBannerConnectedState());
        } else {
          emit(ConnectionBannerDisconnectedState());
        }
      },
    );
  }
}
