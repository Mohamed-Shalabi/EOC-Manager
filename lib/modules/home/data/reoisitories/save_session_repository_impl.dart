import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/save_session_done_entity.dart';
import '../../domain/repositories/save_session_repository.dart';
import '../data_sources/session_data_source.dart';

class SaveSessionRepositoryImpl implements SaveSessionRepository {
  final SessionDataSource _sessionDataSource;

  SaveSessionRepositoryImpl({
    required SessionDataSource sessionDataSource,
  }) : _sessionDataSource = sessionDataSource;

  @override
  Future<Either<Failure, SaveSessionDoneEntity>> saveSession(
    int userHeightInCm,
  ) async {
    try {
      final isSaved = await _sessionDataSource.saveSession(userHeightInCm);

      if (isSaved) {
        return Right(SaveSessionDoneEntity());
      }

      throw AppStrings.couldNotSaveSession;
    } catch (_) {
      return Left(Failure(message: AppStrings.couldNotSaveSession));
    }
  }
}
