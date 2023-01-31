import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../domain/use_cases/send_height_use_case.dart';

part 'send_height_states.dart';

class SendHeightCubit extends Cubit<SendHeightStates> {
  final SendHeightUseCase _sendHeightUseCase;

  final GlobalKey<FormState> heightFormKey;
  final TextEditingController userHeightTextController;

  SendHeightCubit({
    required SendHeightUseCase sendHeightUseCase,
    required this.userHeightTextController,
    required this.heightFormKey,
  })  : _sendHeightUseCase = sendHeightUseCase,
        super(SendHeightInitialState());

  String get _userHeightTrimmedText => userHeightTextController.text.trim();

  int get _userHeight => int.parse(_userHeightTrimmedText);

  void sendHeight() async {
    if (!(heightFormKey.currentState?.validate() ?? true)) {
      return;
    }

    final sendHeightResult = await _sendHeightUseCase(
      SendHeightUseCaseParameters(_userHeight),
    );

    sendHeightResult.fold(
      (failure) => emit(SendHeightFailedState(message: failure.message)),
      (entity) => emit(SendHeightSuccessState(entity.sentMessage)),
    );
  }

  String? validateHeightInput(String? value) {
    final height = int.tryParse(value ?? '');
    if (height == null) {
      return AppStrings.heightFieldHintMessage;
    }

    return null;
  }
}
