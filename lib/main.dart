import 'package:ergonomic_office_chair_manager/core/bluetooth/flutter_bluetooth_serial_connector.dart';
import 'package:ergonomic_office_chair_manager/core/local/shared_preferences_storage_key_value_saver.dart';
import 'package:ergonomic_office_chair_manager/features/home/blocs/home_cubit.dart';
import 'package:ergonomic_office_chair_manager/features/home/data/home_repo.dart';
import 'package:ergonomic_office_chair_manager/features/home/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        homeRepo: HomeRepo(
          SharedPreferencesStorageKeyValueSaver(sharedPreferences),
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
