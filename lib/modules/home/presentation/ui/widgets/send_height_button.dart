import 'package:ergonomic_office_chair_manager/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/my_text.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../blocs/send_height_cubit/send_height_cubit.dart';

class SendHeightButton extends StatelessWidget {
  const SendHeightButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sendHeightViewModel = context.read<SendHeightCubit>();

    return TextButton(
      onPressed: sendHeightViewModel.sendHeight,
      child: const MyText(
        AppStrings.send,
        style: AppTextStyles.buttonStyle,
      ),
    );
  }
}
