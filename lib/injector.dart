import 'package:ergonomic_office_chair_manager/core/bluetooth/fake_bluetooth_connector.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/bluetooth/bluetooth_connector_interface.dart';
import 'core/bluetooth/flutter_bluetooth_serial_connector.dart';
import 'core/local/shared_preferences_storage_key_value_saver.dart';
import 'core/local/storage_key_value_saver.dart';
import 'modules/home/data/data_sources/bluetooth_data_source.dart';
import 'modules/home/data/data_sources/session_data_source.dart';
import 'modules/home/data/reoisitories/connect_to_device_repository_impl.dart';
import 'modules/home/data/reoisitories/connection_stream_repository_impl.dart';
import 'modules/home/data/reoisitories/disconnect_device_repository_impl.dart';
import 'modules/home/data/reoisitories/get_devices_repository_impl.dart';
import 'modules/home/data/reoisitories/save_session_repository_impl.dart';
import 'modules/home/data/reoisitories/send_height_repository_impl.dart';
import 'modules/home/domain/repositories/connect_to_device_repository.dart';
import 'modules/home/domain/repositories/connection_stream_respository.dart';
import 'modules/home/domain/repositories/disconnect_device_repository.dart';
import 'modules/home/domain/repositories/get_devices_repository.dart';
import 'modules/home/domain/repositories/save_session_repository.dart';
import 'modules/home/domain/repositories/send_height_repository.dart';
import 'modules/home/domain/use_cases/connect_to_device_use_case.dart';
import 'modules/home/domain/use_cases/connection_stream_use_case.dart';
import 'modules/home/domain/use_cases/disconnect_device_use_case.dart';
import 'modules/home/domain/use_cases/get_devices_use_case.dart';
import 'modules/home/domain/use_cases/send_height_use_case.dart';
import 'modules/home/presentation/blocs/connect_to_device_cubit/connect_to_device_cubit.dart';
import 'modules/home/presentation/blocs/connection_stream_cubit/connection_stream_cubit.dart';
import 'modules/home/presentation/blocs/disconnect_device_cubit/disconnect_device_cubit.dart';
import 'modules/home/presentation/blocs/get_devices_cubit/get_devices_cubit.dart';
import 'modules/home/presentation/blocs/send_height_cubit/send_height_cubit.dart';

abstract class Injector {
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

  static Future<void> init() async {
    // ---------------------- core ----------------------
    final sharedPreferences = await SharedPreferences.getInstance();

    _serviceLocator.registerSingleton(sharedPreferences);

    _serviceLocator.registerLazySingleton<StorageKeyValueSaver>(
      () => SharedPreferencesStorageKeyValueSaver(get<SharedPreferences>()),
    );

    _serviceLocator.registerLazySingleton<BluetoothConnectorInterface>(
      () => FlutterSerialBluetoothConnector(),
    );

    // ---------------------- modules ----------------------

    // Home
    _serviceLocator.registerLazySingleton(
      () => BluetoothDataSource(bluetoothConnector: get()),
    );

    _serviceLocator.registerLazySingleton(
      () => SessionDataSource(storageKeyValueSaver: get()),
    );

    _serviceLocator.registerLazySingleton<ConnectToDeviceRepository>(
      () => ConnectToDeviceRepositoryImpl(bluetoothDataSource: get()),
    );

    _serviceLocator.registerLazySingleton<ConnectionStreamRepository>(
      () => ConnectionStreamRepositoryImpl(bluetoothDataSource: get()),
    );

    _serviceLocator.registerLazySingleton<DisconnectDeviceRepository>(
      () => DisconnectDeviceRepositoryImpl(bluetoothDataSource: get()),
    );

    _serviceLocator.registerLazySingleton<GetDevicesRepository>(
      () => GetDevicesRepositoryImpl(bluetoothDataSource: get()),
    );

    _serviceLocator.registerLazySingleton<SaveSessionRepository>(
      () => SaveSessionRepositoryImpl(sessionDataSource: get()),
    );

    _serviceLocator.registerLazySingleton<SendHeightRepository>(
      () => SendHeightRepositoryImpl(bluetoothDataSource: get()),
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

    _serviceLocator.registerLazySingleton(
      () => SendHeightUseCase(repository: get()),
    );

    _serviceLocator.registerFactory(
      () => ConnectToDeviceCubit(
        connectToDeviceUseCase: get(),
      ),
    );

    _serviceLocator.registerFactory(
      () => ConnectionStreamCubit(
        connectionStreamUseCase: get(),
      ),
    );

    _serviceLocator.registerFactory(
      () => DisconnectDeviceCubit(
        disconnectDeviceUseCase: get(),
      ),
    );

    _serviceLocator.registerFactory(
      () => GetDevicesCubit(
        getDevicesUseCase: get(),
      ),
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
