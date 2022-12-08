import 'package:ergonomic_office_chair_manager/core/functions/media_query_utils.dart';
import 'package:ergonomic_office_chair_manager/modules/home/presentation/blocs/connection_cubit/connection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectionStatusWidget extends StatelessWidget {
  const ConnectionStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final connectionViewModel = context.watch<ConnectionCubit>();

    return Container(
      width: context.screenWidth * 0.4,
      height: 36,
      decoration: BoxDecoration(
        color: connectionViewModel.isConnected
            ? Colors.greenAccent.shade400
            : Colors.red.shade300,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          connectionViewModel.isConnected
              ? 'Connected'
              : 'Not Connected',
        ),
      ),
    );
  }
}
