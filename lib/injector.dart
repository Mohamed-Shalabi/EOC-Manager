import 'package:ergonomic_office_chair_manager/core/bluetooth/fake_bluetooth_connector.dart';
import 'package:ergonomic_office_chair_manager/modules/home/data/entities/connection_entity_impl.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/entities/connection_entity.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/use_cases/connect_to_device_use_case.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/use_cases/disconnect_device_use_case.dart';
import 'package:ergonomic_office_chair_manager/modules/home/domain/use_cases/send_height_use_case.dart';
import 'package:ergonomic_office_chair_manager/modules/home/presentation/blocs/connection_cubit/connection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/bluetooth/bluetooth_connector_interface.dart';
import 'core/local/shared_preferences_storage_key_value_saver.dart';
import 'core/local/storage_key_value_saver.dart';
import 'modules/home/data/data_sources/bluetooth_data_source.dart';

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
      () => FakeBluetoothConnector(),
    );

    // ---------------------- modules ----------------------

    _serviceLocator.registerLazySingleton(
      () => BluetoothDataSource(bluetoothConnector: get()),
    );

    _serviceLocator.registerLazySingleton<ConnectionEntity>(
      () => ConnectionEntityImpl(get()),
    );

    _serviceLocator.registerLazySingleton(
      () => ConnectToDeviceUseCase(get()),
    );

    _serviceLocator.registerLazySingleton(
      () => DisconnectDeviceUseCase(get()),
    );

    _serviceLocator.registerLazySingleton(
      () => SendHeightUseCase(get()),
    );

    _serviceLocator.registerFactory(
      () => ConnectionCubit(get(), get(), get(), get()),
    );
  }
}
