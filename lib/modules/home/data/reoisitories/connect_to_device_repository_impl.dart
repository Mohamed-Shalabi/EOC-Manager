import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/device_entity.dart';
import '../../domain/repositories/connect_to_device_repository.dart';
import '../data_sources/bluetooth_data_source.dart';
import '../mappers.dart';

class ConnectToDeviceRepositoryImpl implements ConnectToDeviceRepository {
  final BluetoothDataSource _bluetoothDataSource;

  ConnectToDeviceRepositoryImpl({
    required BluetoothDataSource bluetoothDataSource,
  }) : _bluetoothDataSource = bluetoothDataSource;

  @override
  Future<Either<Failure, void>> get isEnabled async {
    try {
      final isEnabled = await _bluetoothDataSource.isEnabled;
      if (isEnabled) {
        return const Right(null);
      }

      throw AppStrings.bluetoothNotEnabled;
    } catch (e) {
      final String message =
          e is String ? e : AppStrings.couldNotCheckBluetoothStatus;
      return Left(Failure(message: message));
    }
  }

  @override
  Future<Either<Failure, void>> connect(
    String deviceId,
  ) async {
    try {
      final isConnected = await _bluetoothDataSource.connect(deviceId);
      if (isConnected) {
        return const Right(null);
      }

      throw AppStrings.couldNotConnect;
    } catch (_) {
      return Left(Failure(message: AppStrings.couldNotConnect));
    }
  }

  @override
  List<DeviceEntity> getDevices() {
    return _bluetoothDataSource.bluetoothDevices
        .map((e) => e.toEntity())
        .toList();
  }
}
