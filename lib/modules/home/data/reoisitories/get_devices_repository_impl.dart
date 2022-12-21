import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/device_entity.dart';
import '../../domain/repositories/get_devices_repository.dart';
import '../data_sources/bluetooth_data_source.dart';
import '../mappers.dart';

class GetDevicesRepositoryImpl implements GetDevicesRepository {
  final BluetoothDataSource _bluetoothDataSource;

  GetDevicesRepositoryImpl({
    required BluetoothDataSource bluetoothDataSource,
  }) : _bluetoothDataSource = bluetoothDataSource;

  @override
  Future<Either<Failure, void>> canConnect() async {
    try {
      final canConnect = await _bluetoothDataSource.isEnabled;
      if (canConnect) {
        return const Right(null);
      }

      throw AppStrings.couldNotConnect;
    } catch (e) {
      final String message =
          e is String ? e : AppStrings.couldNotCheckBluetoothStatus;
      return Left(Failure(message: message));
    }
  }

  @override
  Future<Either<Failure, List<DeviceEntity>>> getDevices() async {
    try {
      final bluetoothDevices = await _bluetoothDataSource.getBluetoothDevices();
      return Right(bluetoothDevices.map((e) => e.toEntity()).toList());
    } catch (_) {
      return Left(Failure(message: AppStrings.couldNotGetDevices));
    }
  }
}
