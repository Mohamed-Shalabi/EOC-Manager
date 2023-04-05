import 'package:ergonomic_office_chair_manager/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stateful_bloc/flutter_stateful_bloc.dart';

import 'core/utils/app_strings.dart';
import 'injector.dart';
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
    return StatefulBlocProvider(
      app: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: AppColors.purple,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
