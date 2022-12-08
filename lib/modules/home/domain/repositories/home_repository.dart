import 'package:dartz/dartz.dart';
import 'package:ergonomic_office_chair_manager/core/error/failure.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/entities/connection_state_entity.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/entities/device_entity.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/entities/ergonomic_height_entity.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/entities/send_done_entity.dart';

import '../entities/can_connect_entity.dart';
import '../entities/save_session_done_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<ErgonomicHeightEntity>>> getErgonomicHeights();

  Future<Either<Failure, CanConnectEntity>> canConnect();

  Stream<ConnectionStateEntity> get connectionStateStream;

  Future<Either<Failure, List<DeviceEntity>>> getDevices();

  Future<Either<Failure, ConnectionStateEntity>> connect(String deviceName);

  Future<Either<Failure, ConnectionStateEntity>> disconnect(String deviceName);

  Future<Either<Failure, SendDoneEntity>> send(int chairHeight);

  Future<Either<Failure, SaveSessionDoneEntity>> saveSession(
      int userHeightInCm);
}
