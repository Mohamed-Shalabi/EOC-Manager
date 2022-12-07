import 'package:dartz/dartz.dart';
import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_connector_interface.dart';
import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_device_model.dart';
import 'package:ergonomic_office_chair_manager/core/local/storage_key_value_saver.dart';
import 'package:ergonomic_office_chair_manager/features/home/data/data_sources/ergonomic_heights_data_source.dart';
import 'package:ergonomic_office_chair_manager/features/home/data/models/ergonomic_height_model.dart';
import 'package:ergonomic_office_chair_manager/features/home/domain/entities/connection_done_entity.dart';
import 'package:ergonomic_office_chair_manager/features/home/domain/entities/device_entity.dart';
import 'package:ergonomic_office_chair_manager/features/home/domain/entities/ergonomic_height_entity.dart';
import 'package:ergonomic_office_chair_manager/features/home/domain/entities/save_session_done_entity.dart';
import 'package:ergonomic_office_chair_manager/features/home/domain/entities/send_done_entity.dart';
import 'package:ergonomic_office_chair_manager/features/home/domain/repositories/home_repository.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/disconnection_done_entity.dart';

class HomeRepositoryImpl implements HomeRepository {
  final StorageKeyValueSaver _storageKeyValueSaver;
  final BluetoothConnectorInterface _bluetoothConnector;

  HomeRepositoryImpl({
    required StorageKeyValueSaver storageKeyValueSaver,
    required BluetoothConnectorInterface bluetoothConnector,
  })  : _storageKeyValueSaver = storageKeyValueSaver,
        _bluetoothConnector = bluetoothConnector;

  var bluetoothDevices = <BluetoothDeviceModel>[];

  @override
  Future<Either<Failure, List<ErgonomicHeightEntity>>>
      getErgonomicHeights() async {
    final heights =
        ErgonomicHeightsDataSource.heights.map((e) => e.toEntity()).toList();
    return Right(heights);
  }

  @override
  Future<Either<Failure, void>> canConnect() async {
    try {
      final canConnect = await _bluetoothConnector.isEnabled;
      if (canConnect) {
        return const Right(null);
      }

      throw 'Could not connect';
    } catch (e) {
      final String message =
          e is String ? e : 'Could not check bluetooth status';
      return Left(Failure(message: message));
    }
  }

  @override
  Future<Either<Failure, List<DeviceEntity>>> getDevices() async {
    try {
      final bluetoothDeviceModels =
          await _bluetoothConnector.getBluetoothDevices();
      bluetoothDevices = bluetoothDeviceModels;
      return Right(bluetoothDeviceModels.map((e) => e.toEntity()).toList());
    } catch (_) {
      return Left(Failure(message: 'Could not get devices'));
    }
  }

  @override
  Future<Either<Failure, ConnectionDoneEntity>> connect(String deviceId) async {
    try {
      final bluetoothDevice =
          bluetoothDevices.firstWhere((element) => element.address == deviceId);
      final isConnected = await _bluetoothConnector.connect(bluetoothDevice);
      if (isConnected) {
        return Right(ConnectionDoneEntity());
      }

      throw 'Could not connect';
    } catch (_) {
      return Left(Failure(message: 'Could not connect'));
    }
  }

  @override
  Future<Either<Failure, SendDoneEntity>> send(int chairHeight) async {
    try {
      _bluetoothConnector.send('$chairHeight');
      return Right(SendDoneEntity());
    } catch (_) {
      return Left(Failure(message: 'Could not send'));
    }
  }

  @override
  Future<bool> isUserHeightInsideRange(int userHeight) async {
    final maxHeight = ErgonomicHeightsDataSource.maxUserHeight;
    final minHeight = ErgonomicHeightsDataSource.minUserHeight;

    return userHeight >= minHeight && userHeight <= maxHeight;
  }

  @override
  Future<Either<Failure, DisconnectionDoneEntity>> disconnect(
    String deviceName,
  ) async {
    try {
      final isDone = await _bluetoothConnector.disconnect();
      if (isDone) {
        return Right(DisconnectionDoneEntity());
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
      final isSaved = await _storageKeyValueSaver.saveData<int>(
        key: 'key',
        value: userHeightInCm,
      );

      if (isSaved) {
        return Right(SaveSessionDoneEntity());
      }

      throw 'could not save session';
    } catch (_) {
      return Left(Failure(message: 'could not save session'));
    }
  }

  Future<int?> getSavedSession() {
    return _storageKeyValueSaver.getData<int>(key: 'key');
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
