import 'package:ergonomic_office_chair_manager/injector.dart';
import 'package:ergonomic_office_chair_manager/modules/home/presentation/blocs/connection_cubit/connection_cubit.dart';
import 'package:ergonomic_office_chair_manager/modules/home/presentation/blocs/send_height_cubit/send_height_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/home/presentation/ui/screens/home_screen.dart';

// TODO: Make deviceId as a class
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Injector.init();

  runApp(const ErgonomicOfficeChairApp());
}

class ErgonomicOfficeChairApp extends StatelessWidget {
  const ErgonomicOfficeChairApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ergonomic Office Chair Manager App',
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => Injector.get<ConnectionCubit>()),
          BlocProvider(create: (_) => Injector.get<SendHeightCubit>()),
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
