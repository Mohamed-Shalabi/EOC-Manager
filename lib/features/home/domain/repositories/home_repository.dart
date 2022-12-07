import 'package:dartz/dartz.dart';
import 'package:ergonomic_office_chair_manager/core/error/failure.dart';
import 'package:ergonomic_office_chair_manager/features/home/domain/entities/connection_done_entity.dart';
import 'package:ergonomic_office_chair_manager/features/home/domain/entities/device_entity.dart';
import 'package:ergonomic_office_chair_manager/features/home/domain/entities/disconnection_done_entity.dart';
import 'package:ergonomic_office_chair_manager/features/home/domain/entities/ergonomic_height_entity.dart';
import 'package:ergonomic_office_chair_manager/features/home/domain/entities/send_done_entity.dart';

import '../entities/save_session_done_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<ErgonomicHeightEntity>>> getErgonomicHeights();

  Future<Either<Failure, void>> canConnect();

  Future<Either<Failure, List<DeviceEntity>>> getDevices();

  Future<Either<Failure, ConnectionDoneEntity>> connect(String deviceName);

  Future<Either<Failure, DisconnectionDoneEntity>> disconnect(String deviceName);

  Future<Either<Failure, SendDoneEntity>> send(int chairHeight);

  Future<bool> isUserHeightInsideRange(int userHeight);

  Future<Either<Failure, SaveSessionDoneEntity>> saveSession(int userHeightInCm);
}
