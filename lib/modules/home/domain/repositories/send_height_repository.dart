import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/ergonomic_height_entity.dart';
import '../entities/send_done_entity.dart';

abstract class SendHeightRepository {
  Future<Either<Failure, List<ErgonomicHeightEntity>>> getErgonomicHeights();

  Future<Either<Failure, SendDoneEntity>> send(int chairHeight);
}
