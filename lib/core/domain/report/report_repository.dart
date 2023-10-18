import 'package:app/core/domain/report/input/report_input.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ReportRepository {
  Future<Either<Failure, bool>> reportPost({required ReportInput input});

  Future<Either<Failure, bool>> reportEvent({required ReportInput input});
}
