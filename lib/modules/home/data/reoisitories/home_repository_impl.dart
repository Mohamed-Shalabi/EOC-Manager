import 'package:dartz/dartz.dart';
import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_device_model.dart';
import 'package:ergonomic_office_chair_manager/modules/home/data/data_sources/bluetooth_data_source.dart';
import 'package:ergonomic_office_chair_manager/modules/home/data/data_sources/ergonomic_heights_data_source.dart';
import 'package:ergonomic_office_chair_manager/modules/home/data/data_sources/session_data_source.dart';
import 'package:ergonomic_office_chair_manager/modules/home/data/models/ergonomic_height_model.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/entities/connection_state_entity.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/entities/device_entity.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/entities/ergonomic_height_entity.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/entities/save_session_done_entity.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/entities/send_done_entity.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/repositories/home_repository.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/can_connect_entity.dart';

class HomeRepositoryImpl implements HomeRepository {
  final SessionDataSource _sessionDataSource;
  final BluetoothDataSource _bluetoothDataSource;

  HomeRepositoryImpl({
    required SessionDataSource sessionDataSource,
    required BluetoothDataSource bluetoothDataSource,
  })  : _sessionDataSource = sessionDataSource,
        _bluetoothDataSource = bluetoothDataSource;

  @override
  Future<Either<Failure, List<ErgonomicHeightEntity>>>
      getErgonomicHeights() async {
    final heights =
        ErgonomicHeightsDataSource.heights.map((e) => e.toEntity()).toList();
    return Right(heights);
  }

  @override
  Future<Either<Failure, CanConnectEntity>> canConnect() async {
    try {
      final canConnect = await _bluetoothDataSource.isEnabled;
      if (canConnect) {
        return Right(CanConnectEntity());
      }

      throw 'Could not connect';
    } catch (e) {
      final String message =
          e is String ? e : 'Could not check bluetooth status';
      return Left(Failure(message: message));
    }
  }

  @override
  Stream<ConnectionStateEntity> get connectionStateStream {
    return _bluetoothDataSource.isConnectedStream.map((isConnected) {
      if (isConnected) {
        return ConnectionStateEntity.connected();
      } else {
        return ConnectionStateEntity.disconnected();
      }
    });
  }

  @override
  Future<Either<Failure, List<DeviceEntity>>> getDevices() async {
    try {
      final bluetoothDevices = await _bluetoothDataSource.getBluetoothDevices();
      return Right(bluetoothDevices.map((e) => e.toEntity()).toList());
    } catch (_) {
      return Left(Failure(message: 'Could not get devices'));
    }
  }

  @override
  Future<Either<Failure, ConnectionStateEntity>> connect(
    String deviceId,
  ) async {
    try {
      final isConnected = await _bluetoothDataSource.connect(deviceId);
      if (isConnected) {
        return Right(ConnectionStateEntity.connected());
      }

      throw 'Could not connect';
    } catch (_) {
      return Left(Failure(message: 'Could not connect'));
    }
  }

  @override
  Future<Either<Failure, SendDoneEntity>> send(int chairHeight) async {
    final isHeightInRange = _isChairHeightInsideRange(chairHeight);
    if (!isHeightInRange) {
      return Left(
        Failure(
          message: 'Height is not in range '
              '(${ErgonomicHeightsDataSource.minUserHeight}, '
              '${ErgonomicHeightsDataSource.maxUserHeight})',
        ),
      );
    }

    _bluetoothDataSource.send(chairHeight);
    return Right(SendDoneEntity());
  }

  bool _isChairHeightInsideRange(int chairHeight) {
    return ErgonomicHeightsDataSource.isInsideRange(chairHeight);
  }

  @override
  Future<Either<Failure, ConnectionStateEntity>> disconnect(
    String deviceName,
  ) async {
    try {
      final isDone = await _bluetoothDataSource.disconnect();
      if (isDone) {
        return Right(ConnectionStateEntity.disconnected());
      }

      throw 'Could not disconnect';
    } catch (_) {
      return Left(Failure(message: 'Could not disconnect'));
    }
  }

  @override
  Future<Either<Failure, SaveSessionDoneEntity>> saveSession(
    int userHeightInCm,
  ) async {
    try {
      final isSaved = await _sessionDataSource.saveSession(userHeightInCm);

      if (isSaved) {
        return Right(SaveSessionDoneEntity());
      }

      throw 'could not save session';
    } catch (_) {
      return Left(Failure(message: 'could not save session'));
    }
  }

  Future<int?> getSavedSession() {
    return _sessionDataSource.getSavedSession();
  }
}

extension on ErgonomicHeightModel {
  ErgonomicHeightEntity toEntity() {
    return ErgonomicHeightEntity(
      userHeightInCm: userHeightInCm,
      chairHeightInCm: chairHeightInCm,
      monitorHeightInCm: monitorHeightInCm,
    );
  }
}

extension on BluetoothDeviceModel {
  DeviceEntity toEntity() {
    return DeviceEntity(name: name, id: address);
  }
}
