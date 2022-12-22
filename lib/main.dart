import 'package:ergonomic_office_chair_manager/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/utils/app_strings.dart';
import 'injector.dart';
import 'modules/home/presentation/blocs/connect_to_device_cubit/connect_to_device_cubit.dart';
import 'modules/home/presentation/blocs/connection_stream_cubit/connection_stream_cubit.dart';
import 'modules/home/presentation/blocs/disconnect_device_cubit/disconnect_device_cubit.dart';
import 'modules/home/presentation/blocs/get_devices_cubit/get_devices_cubit.dart';
import 'modules/home/presentation/blocs/send_height_cubit/send_height_cubit.dart';
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
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors.purple,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => Injector.get<ConnectToDeviceCubit>()),
          BlocProvider(create: (_) => Injector.get<ConnectionStreamCubit>()),
          BlocProvider(create: (_) => Injector.get<DisconnectDeviceCubit>()),
          BlocProvider(create: (_) => Injector.get<GetDevicesCubit>()),
          BlocProvider(create: (_) => Injector.get<SendHeightCubit>()),
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
