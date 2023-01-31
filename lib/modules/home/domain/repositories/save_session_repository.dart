import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/save_session_done_entity.dart';

abstract class SaveSessionRepository {
  Future<Either<Failure, SaveSessionDoneEntity>> saveSession(
      int userHeightInCm);
}
