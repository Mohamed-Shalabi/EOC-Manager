import 'package:ergonomic_office_chair_manager/core/functions/show_snack_bar.dart';
import 'package:ergonomic_office_chair_manager/modules/home/presentation/blocs/home_animations_cubit/home_animations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/connection_cubit/connection_cubit.dart';

class HomeListeners extends StatelessWidget {
  const HomeListeners({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectionCubit, ConnectionStates>(
      listener: (BuildContext context, ConnectionStates state) {
        if (state.messagingState != UIMessagingState.idle) {
          context.showSnackBar(state.message);
        }
      },
      child: child,
    );
  }
}
