import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/ergonomic_height_entity.dart';
import '../../domain/entities/send_done_entity.dart';
import '../../domain/repositories/send_height_repository.dart';
import '../data_sources/bluetooth_data_source.dart';
import '../data_sources/ergonomic_heights_data_source.dart';
import '../mappers.dart';

class SendHeightRepositoryImpl implements SendHeightRepository {
  final BluetoothDataSource _bluetoothDataSource;

  SendHeightRepositoryImpl({
    required BluetoothDataSource bluetoothDataSource,
  }) : _bluetoothDataSource = bluetoothDataSource;

  @override
  Future<Either<Failure, List<ErgonomicHeightEntity>>>
      getErgonomicHeights() async {
    final heights =
        ErgonomicHeightsDataSource.heights.map((e) => e.toEntity()).toList();
    return Right(heights);
  }

  @override
  Future<Either<Failure, SendDoneEntity>> send(int chairHeight) async {
    final isHeightInRange = _isChairHeightInsideRange(chairHeight);
    if (!isHeightInRange) {
      return Left(
        Failure(
          message: '${AppStrings.heightNotInRange} '
              '(${ErgonomicHeightsDataSource.minUserHeight}, '
              '${ErgonomicHeightsDataSource.maxUserHeight})',
        ),
      );
    }

    final sentMessage = _bluetoothDataSource.send(chairHeight);
    return Right(SendDoneEntity(sentMessage));
  }

  bool _isChairHeightInsideRange(int chairHeight) {
    return ErgonomicHeightsDataSource.isInsideRange(chairHeight);
  }
}
