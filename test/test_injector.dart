import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_connector_interface.dart';
import 'package:ergonomic_office_chair_manager/core/local/storage_key_value_saver.dart';
import 'package:ergonomic_office_chair_manager/modules/home/data/data_sources/bluetooth_data_source.dart';
import 'package:ergonomic_office_chair_manager/modules/home/data/data_sources/session_data_source.dart';
import 'package:ergonomic_office_chair_manager/modules/home/data/reoisitories/home_repository_impl.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/repositories/home_repository.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/use_cases/connect_to_device_use_case.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/use_cases/connection_stream_use_case.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/use_cases/disconnect_device_use_case.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/use_cases/get_devices_use_case.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/use_cases/send_height_use_case.dart';
import 'package:ergonomic_office_chair_manager/modules/home/presentation/blocs/connection_cubit/connection_cubit.dart';
import 'package:ergonomic_office_chair_manager/modules/home/presentation/blocs/send_height_cubit/send_height_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import 'core/bluetooth/bluetooth_test_connector.dart';
import 'core/storage/test_key_value_saver.dart';

abstract class TestInjector {
  static final _serviceLocator = GetIt.instance;

  static T get<T extends Object>({
    String? instanceName,
    dynamic parameters,
  }) {
    if (T == dynamic) {
      throw 'cannot inject dynamic object';
    }

    return _serviceLocator<T>(
      instanceName: instanceName,
      param1: parameters,
    );
  }

  static void init() {
    // ---------------------- core ----------------------
    _serviceLocator.registerLazySingleton<StorageKeyValueSaver>(
      () => TestKeyValueSaver(),
    );

    _serviceLocator.registerLazySingleton<BluetoothConnectorInterface>(
      () => BluetoothTestConnector(),
    );

    // ---------------------- modules ----------------------
    // Home
    _serviceLocator.registerLazySingleton(
      () => BluetoothDataSource(bluetoothConnector: get()),
    );

    _serviceLocator.registerLazySingleton(
      () => SessionDataSource(storageKeyValueSaver: get()),
    );

    _serviceLocator.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(
        sessionDataSource: get(),
        bluetoothDataSource: get(),
      ),
    );

    _serviceLocator.registerLazySingleton(
      () => ConnectionStreamUseCase(repository: get()),
    );

    _serviceLocator.registerLazySingleton(
      () => GetDevicesUseCase(repository: get()),
    );

    _serviceLocator.registerLazySingleton(
      () => ConnectToDeviceUseCase(repository: get()),
    );

    _serviceLocator.registerLazySingleton(
      () => DisconnectDeviceUseCase(repository: get()),
    );

    _serviceLocator.registerFactory<ConnectionCubit>(
      () => ConnectionCubit(
        connectionStreamUseCase: get(),
        getDevicesUseCase: get(),
        connectToDeviceUseCase: get(),
        disconnectDeviceUseCase: get(),
      ),
    );

    _serviceLocator.registerLazySingleton(
      () => SendHeightUseCase(repository: get()),
    );

    _serviceLocator.registerFactory(
      () => SendHeightCubit(
        sendHeightUseCase: get(),
        userHeightTextController: TextEditingController(),
        heightFormKey: GlobalKey<FormState>(),
      ),
    );
  }
}
