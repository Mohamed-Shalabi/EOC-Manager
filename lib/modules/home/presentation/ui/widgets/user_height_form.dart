import 'package:ergonomic_office_chair_manager/modules/home/presentation/blocs/send_height_cubit/send_height_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserHeightForm extends StatelessWidget {
  const UserHeightForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sendHeightViewModel = context.watch<SendHeightCubit>();

    return Form(
      key: sendHeightViewModel.heightFormKey,
      child: TextFormField(
        controller: sendHeightViewModel.userHeightTextController,
        decoration: InputDecoration(
          hintText: 'Enter your height in English Letters',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: sendHeightViewModel.validateHeightInput,
      ),
    );
  }
}
