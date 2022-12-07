import 'package:ergonomic_office_chair_manager/core/functions/string_to_u_int_8_list.dart';
import 'package:ergonomic_office_chair_manager/features/home/data/ergonomic_calculator.dart';
import 'package:ergonomic_office_chair_manager/features/home/domain/use_cases/send_height_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

import 'home/repository.dart';

void main() {
  test(
    'Testing the sending format',
    () {
      expect([52, 52], '44'.toUInt8List);
    },
  );

  test(
    'SendHeightUseCase Test',
    () async {
      final repository = TestHomeRepository();
      final SendHeightUseCase useCase = SendHeightUseCase(repository);
      final heightInRange = SendHeightUseCaseParameters(
        (ErgonomicHeightCalculator.maxUserHeight +
                ErgonomicHeightCalculator.minUserHeight) ~/
            2,
      );
      expect(await useCase(heightInRange), true);
      final heightOutRange = SendHeightUseCaseParameters(
        ErgonomicHeightCalculator.maxUserHeight + 20,
      );
      expect(await useCase(heightOutRange), false);
    },
  );
}
