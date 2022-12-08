import 'package:ergonomic_office_chair_manager/modules/home/presentation/blocs/send_height_cubit/send_height_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendHeightButton extends StatelessWidget {
  const SendHeightButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sendHeightViewModel = context.read<SendHeightCubit>();

    return TextButton(
      onPressed: sendHeightViewModel.sendHeight,
      child: const Text(
        'Send',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
