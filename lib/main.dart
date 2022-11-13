import 'package:ergonomic_office_chair_manager/core/bluetooth/flutter_bluetooth_serial_connector.dart';
import 'package:ergonomic_office_chair_manager/features/home/blocs/home_cubit.dart';
import 'package:ergonomic_office_chair_manager/features/home/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const ErgonomicOfficeChairApp());
}

class ErgonomicOfficeChairApp extends StatelessWidget {
  const ErgonomicOfficeChairApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        bluetoothConnector: FlutterBluetoothSerialConnector(),
      ),
      child: const MaterialApp(
        title: 'Ergonomic Office Chair Manager App',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
