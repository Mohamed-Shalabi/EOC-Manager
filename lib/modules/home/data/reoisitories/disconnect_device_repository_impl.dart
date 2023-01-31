import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/repositories/disconnect_device_repository.dart';
import '../data_sources/bluetooth_data_source.dart';

class DisconnectDeviceRepositoryImpl implements DisconnectDeviceRepository {
  final BluetoothDataSource _bluetoothDataSource;

  DisconnectDeviceRepositoryImpl({
    required BluetoothDataSource bluetoothDataSource,
  }) : _bluetoothDataSource = bluetoothDataSource;

  @override
  Future<Either<Failure, void>> disconnect() async {
    try {
      final isDone = await _bluetoothDataSource.disconnect();
      if (isDone) {
        return const Right(null);
      }

      throw AppStrings.couldNotDisconnect;
    } catch (_) {
      return Left(Failure(message: AppStrings.couldNotDisconnect));
    }
  }
}
