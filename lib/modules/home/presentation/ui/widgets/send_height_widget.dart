import 'package:ergonomic_office_chair_manager/injector.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/my_text.dart';
import '../../../../../core/functions/media_query_utils.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../blocs/send_height_cubit/send_height_cubit.dart';

class SendHeightWidget extends StatelessWidget {
  const SendHeightWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: context.screenHeight * 0.06),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
          child: UserHeightForm(),
        ),
        const SendHeightButton(),
      ],
    );
  }
}

class UserHeightForm extends StatelessWidget {
  const UserHeightForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sendHeightViewModel = Injector.get<SendHeightCubit>();

    return Form(
      key: sendHeightViewModel.heightFormKey,
      child: TextFormField(
        controller: sendHeightViewModel.userHeightTextController,
        style: AppTextStyles.whiteTitleStyle,
        decoration: InputDecoration(
          hintText: AppStrings.heightFieldHintMessage,
          hintStyle: AppTextStyles.whiteSubTitleStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.white),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.white),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.white),
          ),
          errorStyle: AppTextStyles.whiteSubTitleStyle,
        ),
        validator: sendHeightViewModel.validateHeightInput,
      ),
    );
  }
}

class SendHeightButton extends StatelessWidget {
  const SendHeightButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sendHeightViewModel = Injector.get<SendHeightCubit>();

    return TextButton(
      onPressed: sendHeightViewModel.sendHeight,
      child: const MyText(
        AppStrings.send,
        style: AppTextStyles.buttonStyle,
      ),
    );
  }
}
