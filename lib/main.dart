import 'package:ergonomic_office_chair_manager/core/bluetooth/flutter_bluetooth_serial_connector.dart';
import 'package:ergonomic_office_chair_manager/core/local/shared_preferences_storage_key_value_saver.dart';
import 'package:ergonomic_office_chair_manager/features/home/data/reoisitories/home_repository_impl.dart';
import 'package:ergonomic_office_chair_manager/features/home/presentation/blocs/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/home/presentation/ui/home_screen.dart';

// TODO: Make deviceId as a class
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(ErgonomicOfficeChairApp(sharedPreferences: sharedPreferences));
}

class ErgonomicOfficeChairApp extends StatelessWidget {
  const ErgonomicOfficeChairApp({Key? key, required this.sharedPreferences})
      : super(key: key);

  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        bluetoothConnector: FlutterSerialBluetoothConnector(),
        homeRepo: HomeRepositoryImpl(
          storageKeyValueSaver: SharedPreferencesStorageKeyValueSaver(
            sharedPreferences,
          ),
          bluetoothConnector: FlutterSerialBluetoothConnector(),
        ),
      ),
      child: const MaterialApp(
        title: 'Ergonomic Office Chair Manager App',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
