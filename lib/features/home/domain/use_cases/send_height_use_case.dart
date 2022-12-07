import 'package:dartz/dartz.dart';
import 'package:ergonomic_office_chair_manager/core/business/use_case.dart';
import 'package:ergonomic_office_chair_manager/features/home/domain/entities/ergonomic_height_entity.dart';
import 'package:ergonomic_office_chair_manager/features/home/domain/entities/send_done_entity.dart';
import 'package:ergonomic_office_chair_manager/features/home/domain/repositories/home_repository.dart';

import '../../../../core/error/failure.dart';

class SendHeightUseCase
    implements
        UseCase<Future<Either<Failure, SendDoneEntity>>,
            SendHeightUseCaseParameters> {
  final HomeRepository _repository;

  SendHeightUseCase(HomeRepository repository) : _repository = repository;

  @override
  Future<Either<Failure, SendDoneEntity>> call(
      SendHeightUseCaseParameters params) async {
    try {
      final isUserHeightInRange = await _repository.isUserHeightInsideRange(
        params.userHeight,
      );
      if (!isUserHeightInRange) {
        throw 'Not in range';
      }

      final heights = await getErgonomicHeights();

      final chairHeight = calculateHeights(
        heights,
        params.userHeight,
      ).chairHeightInCm;

      return _repository.send(chairHeight);
    } catch (e) {
      final message = e is String ? e : 'could not send heights';
      return Left(Failure(message: message));
    }
  }

  ErgonomicHeightEntity calculateHeights(
    List<ErgonomicHeightEntity> heights,
    int userHeightInCm,
  ) {
    return heights.firstWhere(
      (element) => element.userHeightInCm > userHeightInCm,
    );
  }

  Future<List<ErgonomicHeightEntity>> getErgonomicHeights() async {
    final result = await _repository.getErgonomicHeights();
    return result.fold<List<ErgonomicHeightEntity>>(
      (failure) => throw failure.message,
      (heights) => heights,
    );
  }
}

class SendHeightUseCaseParameters extends UseCaseParameters {
  final int userHeight;

  SendHeightUseCaseParameters(this.userHeight);
}
